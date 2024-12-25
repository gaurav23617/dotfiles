#!/bin/sh

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# History Configuration
export HISTFILE=~/.zsh_history # Use this path consistently
export HISTSIZE=1000000
export SAVEHIST=1000000
HISTDUP=erase

# History options
setopt APPEND_HISTORY             # Append history to the file
setopt SHARE_HISTORY              # Share history across all sessions
setopt HIST_IGNORE_SPACE          # Ignore commands that start with a space
setopt HIST_IGNORE_DUPS           # Ignore duplicate commands
setopt INC_APPEND_HISTORY         # Write history incrementally to the file
setopt HIST_SAVE_NO_DUPS          # Do not save duplicate entries in the history file
setopt HIST_FIND_NO_DUPS          # Do not display duplicate commands in history searches


# Add in Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/zstyle.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# Add in zsh plugins
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-completions"
# plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "zsh-users/zsh-syntax-highlighting"

# Load completions
autoload -Uz compinit && compinit
