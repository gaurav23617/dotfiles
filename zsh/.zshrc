#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Add in Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(fnm env)"
eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"


# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/zstyle.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# Add in zsh plugins
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/exa"
# plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# Load completions
autoload -Uz compinit && compinit
