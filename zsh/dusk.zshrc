# Load modules from config
CONFIG_DIR="$HOME/.config/zsh/modules"
for module in "$CONFIG_DIR"/*.zshrc; do
  if [[ -f "$module" ]]; then
    source "$module"
    # echo "Loaded module: $module"
  fi
done

# Welcoming quote
fortune -n 100 | cowsay | lolcat
