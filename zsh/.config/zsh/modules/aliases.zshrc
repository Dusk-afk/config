##############################################
#                 ALIASES                    #
##############################################

### General
alias clr='clear'
alias ctr='cd ~'
alias ll='eza -la --icons'
alias zedit='nvim $HOME/.zshrc'
alias sauce='source $HOME/.zshrc'
alias vsauce='source .venv/bin/activate'

### Git
alias gp='git pull'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gd='git checkout -D'
alias gcm='git commit -m'

### Gradle (Spring Boot)
alias gb='./gradlew build'
alias gbt='./gradlew build -x test'
alias gcl='./gradlew clean'
alias gclb='./gradlew clean build'
alias gt='./gradlew test'
alias ga='./gradlew assemble'
alias gr='./gradlew bootRun'

### Java switching (SDKMAN)
alias uj17='sdk use java 17.0.12-tem'
alias uj21='sdk use java 21.0.8-tem'

##############################################
#             FZF POWER ALIASES              #
##############################################

# Checkout local branches
alias gcf='git branch | fzf | xargs git checkout'

# Checkout remote branches
alias gcr='git branch -r | sed "s/origin\///" | fzf | xargs git checkout'

# Inspect commits w/ preview
alias glp='git log --oneline | fzf --preview "git show --color=always {1}"'

# Process lookup
alias plook='ps aux | fzf --preview "
echo {} | awk '\''{
  cmd=\"\";
  for (i=11; i<=NF; i++) cmd = cmd \$i \" \";
  printf \"\033[1;36mPID:\033[0m %s\n\", \$2;
  printf \"\033[1;36mCPU:\033[0m %s\n\", \$3;
  printf \"\033[1;36mMEM:\033[0m %s\n\", \$4;
  printf \"\033[1;36mSTART:\033[0m %s\n\", \$9;
  printf \"\033[1;36mTIME:\033[0m %s\n\", \$10;
  printf \"\033[1;36mCMD:\033[0m %s\n\", cmd;
}'\''"'

# Process kill
alias pkill='plook | awk '\''{print $2}'\'' | xargs kill'

# Force kill
alias pkill9='plook | awk '\''{print $2}'\'' | xargs kill -9'