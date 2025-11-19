#!/bin/sh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Should be called before compinit
zmodload zsh/complist

# Load completions
autoload -Uz _zinit && compinit && compinit
(( ${+_comps} )) && _comps[zinit]=_zinit

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# Use a persistent, fast zcompdump location
ZCDUMP="$HOME/.cache/zcompdump"


# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-history-substring-search
zinit load zdharma-continuum/history-search-multi-word


# source
zinit snippet "$HOME/.config/zsh/zstyle.zsh"
zinit snippet "$HOME/.config/zsh/aliases.zsh"
zinit snippet "$HOME/.config/zsh/exports.zsh"
zinit snippet "$HOME/.config/zsh/functions.zsh"
zinit snippet "$HOME/.config/zsh/Keybindings.zsh"
zinit snippet "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

# source
# source "$HOME/.config/zsh/aliases.zsh"
# source "$HOME/.config/zsh/zstyle.zsh"
# source "$HOME/.config/zsh/exports.zsh"
# source "$HOME/.config/zsh/functions.zsh"
# source "$HOME/.config/zsh/Keybindings.zsh"
# source "$HOME/dotfiles/config/zsh/Keybindings.zsh"
# source "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"


# Prevent Zsh from throwing errors on unmatched globs (e.g. *, ?, # in commands)
setopt no_nomatch
# source <(carapace _carapace)

# Add in Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(fnm env)"
eval "$(zoxide init --cmd cd zsh)"
# eval "`pip completion --zsh`"
# eval "$(<Homebrew prefix path>/bin/brew shellenv)"
