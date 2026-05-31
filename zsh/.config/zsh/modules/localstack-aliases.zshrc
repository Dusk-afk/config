##############################################
#           LOCALSTACK HELPERS               #
##############################################

_LS_ENDPOINT="http://localhost:4566"
_LS_REGION="ap-south-1"
_LS_ACCOUNT="000000000000"

# Check LocalStack health
ls-health() {
  curl -s "${_LS_ENDPOINT}/_localstack/health"
}

# List all state machines
ls-list-sms() {
  aws --endpoint-url="${_LS_ENDPOINT}" \
      --region="${_LS_REGION}" \
      --output json \
      stepfunctions list-state-machines
}

# List all SQS queues
ls-list-queues() {
  aws --endpoint-url="${_LS_ENDPOINT}" \
      --region="${_LS_REGION}" \
      --output json \
      sqs list-queues
}

# List executions of a state machine
# Usage: ls-list-executions <state-machine-name|arn> [RUNNING|SUCCEEDED|FAILED|ABORTED|TIMED_OUT]
_ls-sm-arn() {
  if [[ "$1" == arn:* ]]; then
    echo "$1"
  else
    echo "arn:aws:states:${_LS_REGION}:${_LS_ACCOUNT}:stateMachine:$1"
  fi
}

ls-list-executions() {
  if [[ -z "$1" ]]; then
    echo "Usage: ls-list-executions <state-machine-name|arn> [RUNNING|SUCCEEDED|FAILED|ABORTED|TIMED_OUT]"
    return 1
  fi
  local arn
  arn=$(_ls-sm-arn "$1")
  local args=(--endpoint-url="${_LS_ENDPOINT}" --region="${_LS_REGION}" --output json
              stepfunctions list-executions --state-machine-arn "${arn}")
  [[ -n "$2" ]] && args+=(--status-filter "$2")
  aws "${args[@]}"
}

# Abort a running execution
# Usage: ls-abort-execution <execution-arn>
ls-abort-execution() {
  if [[ -z "$1" ]]; then
    echo "Usage: ls-abort-execution <execution-arn>"
    return 1
  fi
  aws --endpoint-url="${_LS_ENDPOINT}" \
      --region="${_LS_REGION}" \
      --output json \
      stepfunctions stop-execution --execution-arn "$1"
}

# Send a message to SQS from a JSON file
# Usage: ls-send-message <json-file>
# JSON file must have: QueueUrl, MessageBody (object), MessageAttributes (object)
ls-send-message() {
  if [[ -z "$1" ]]; then
    echo "Usage: ls-send-message <json-file>"
    return 1
  fi
  if [[ ! -f "$1" ]]; then
    echo "Error: file not found: $1"
    return 1
  fi
  local queue_url message_body message_attributes
  queue_url=$(jq -r '.QueueUrl' "$1")
  message_body=$(jq -c '.MessageBody' "$1")
  message_attributes=$(jq -c '.MessageAttributes' "$1")
  aws --endpoint-url="${_LS_ENDPOINT}" \
      --region="${_LS_REGION}" \
      --output json \
      sqs send-message \
      --queue-url "${queue_url}" \
      --message-body "${message_body}" \
      --message-attributes "${message_attributes}"
}

# Get event history of an execution (latest events first)
# Usage: ls-execution-history <execution-arn>
ls-execution-history() {
  if [[ -z "$1" ]]; then
    echo "Usage: ls-execution-history <execution-arn>"
    return 1
  fi
  aws --endpoint-url="${_LS_ENDPOINT}" \
      --region="${_LS_REGION}" \
      --output json \
      stepfunctions get-execution-history \
      --execution-arn "$1" \
      --reverse-order
}


# Abort ALL running executions across ALL state machines
# Usage: ls-abort-all-executions
ls-abort-all-executions() {
  echo "Fetching all state machines..."

  aws --endpoint-url="${_LS_ENDPOINT}" \
      --region="${_LS_REGION}" \
      --output json \
      stepfunctions list-state-machines \
  | jq -r '.stateMachines[].stateMachineArn' \
  | while read -r sm_arn; do

      echo "Checking running executions for: $sm_arn"

      aws --endpoint-url="${_LS_ENDPOINT}" \
          --region="${_LS_REGION}" \
          --output json \
          stepfunctions list-executions \
          --state-machine-arn "$sm_arn" \
          --status-filter RUNNING \
      | jq -r '.executions[].executionArn' \
      | while read -r exec_arn; do

          echo "Aborting execution: $exec_arn"

          aws --endpoint-url="${_LS_ENDPOINT}" \
              --region="${_LS_REGION}" \
              --output json \
              stepfunctions stop-execution \
              --execution-arn "$exec_arn" >/dev/null
      done
  done

  echo "Done."
}

