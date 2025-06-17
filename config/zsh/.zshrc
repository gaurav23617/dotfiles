#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Download Zinit, if it's not there yet
if [ ! -d "$ZAP_DIR" ]; then
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v --keep
fi

# Set the directory we want to store Zap and plugins
ZAP_DIR="$HOME/.local/share/zap"

# Add in Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(fnm env)"
eval "$(zoxide init --cmd cd zsh)"
# eval "`pip completion --zsh`"

# source
plug "$HOME/dotfiles/config/zsh/aliases.zsh"
plug "$HOME/dotfiles/config/zsh/zstyle.zsh"
plug "$HOME/dotfiles/config/zsh/exports.zsh"
plug "$HOME/dotfiles/config/zsh/functions.zsh"
plug "$HOME/dotfiles/config/zsh/plugins.zsh.zsh"

# Add in zsh plugins
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# Prevent Zsh from throwing errors on unmatched globs (e.g. *, ?, # in commands)
setopt no_nomatch
