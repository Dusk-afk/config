##############################################
#                CORE TOOLS                  #
##############################################

# zoxide (jump directories)
eval "$(zoxide init zsh)"

# fzf keybindings & completion
source <(fzf --zsh)

# Use fd as default fzf search backend
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden'
# FZF Catppuccin Mocha Theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# Autosuggestions (fast)
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Catppuccin theme for syntax highlighting
#source "$HOME/config/zsh/.config/zsh/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"
# Syntax highlighting
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Starship prompt (clean, fast)
eval "$(starship init zsh)"

# Carapace for command completion suggestions
# Currently not working as expected
#export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
#zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
#source <(carapace _carapace)

##############################################
#             ALIASED PROGRAMS               #
##############################################

alias lolcat='python3 $HOME/programming/lolcat/lolcat.py'

##############################################
#             CUSTOM FUNCTIONS               #
##############################################

# Kill process by port
portkill() {
  if [ -z "$1" ]; then
    echo "Usage: portkill <port>"
    return 1
  fi

  pid=$(lsof -ti :"$1")
  if [ -z "$pid" ]; then
    echo "No process found on port $1"
    return 1
  fi

  echo "Killing process $pid on port $1"
  kill "$pid"
}
