##############################################
#                PATH SETUP                  #
##############################################

# Base paths
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/aws-cli:$PATH"
export PATH="$HOME/Python/3.9/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# pipx adds its own entry
export PATH="$PATH:$HOME/.local/bin"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Platform tools
export PATH="$HOME/platform-tools:$PATH"