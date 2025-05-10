#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Download Zinit, if it's not there yet
if [ ! -d "$ZAP_DIR" ]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v --keep
fi

# Add in Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Set the directory we want to store zinit and plugins
ZAP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zap"

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(fnm env)"
eval "$(zoxide init --cmd cd zsh)"
# eval "`pip completion --zsh`"

# source
plug "$HOME/dotfile/config/zsh/aliases.zsh"
plug "$HOME/dotfile/config/zsh/zstyle.zsh"
plug "$HOME/dotfile/config/zsh/exports.zsh"
plug "$HOME/dotfile/config/zsh/functions.zsh"
plug "$HOME/dotfile/config/zsh/plugins.zsh.zsh"


