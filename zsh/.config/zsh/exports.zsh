#!/bin/sh

# History Configuration
HISTFILE=~/.zsh_history # Use this path consistently
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase

# History options
setopt APPEND_HISTORY             # Append history to the file
setopt SHARE_HISTORY              # Share history across all sessions
setopt HIST_IGNORE_SPACE          # Ignore commands that start with a space
setopt HIST_IGNORE_DUPS           # Ignore duplicate commands
setopt INC_APPEND_HISTORY         # Write history incrementally to the file
setopt HIST_SAVE_NO_DUPS          # Do not save duplicate entries in the history file
setopt HIST_FIND_NO_DUPS          # Do not display duplicate commands in history searches

export EDITOR="nvim"
# export TERMINAL="kitty"
# export BROWSER="firefox"
# export PATH="$HOME/.local/bin":$PATH
# export PATH="$HOME/.docker/bin":$PATH
# export PATH="$HOME/.local/nvim-macos-arm64/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# export PATH=$HOME/.cargo/bin:$PATH
# export PATH=$HOME/.local/share/go/bin:$PATH
# export GOPATH=$HOME/.local/share/go
# export PATH=$HOME/.fnm:$PATH
# export PATH="$HOME/.local/share/neovim/bin":$PATH
# export PATH="$HOME/.local/share/bob/nvim-bin":$PATH
# export XDG_CURRENT_DESKTOP="Wayland"
# export HOMEBREW_NO_ANALYTICS=1
# export HOMEBREW_NO_ENV_HINTS=1

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(fnm env)"
eval "$(zoxide init zsh)"
# eval "`pip completion --zsh`"

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
  export DYLD_LIBRARY_PATH=/opt/homebrew/lib/
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib
	;;

Linux)
	;;
esac
