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
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

export EDITOR="nvim"
export TERMINAL="ghostty"
export BROWSER="zen-browser"
export BROWSER="zen"
export PATH="$HOME/.local/bin":$PATH
export PATH=$PATH:/usr/bin
export PATH="$HOME/.npm-global/bin:$PATH"
# export PATH="$HOME/.docker/bin":$PATH
# export PATH="$HOME/.local/nvim-macos-arm64/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
# export PATH=$HOME/.cargo/bin:$PATH
# export PATH=$HOME/.local/share/go/bin:$PATH
# export GOPATH=$HOME/.local/share/go
# export PATH="$HOME/.local/share/neovim/bin":$PATH
export XDG_CURRENT_DESKTOP="Wayland"
# export HOMEBREW_NO_ANALYTICS=1
# export HOMEBREW_NO_ENV_HINTS=1
# Open in tmux popup if on tmux, otherwise use --height mode
# export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
export NIX_CONFIG="experimental-features = nix-command flakes"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
export LS_COLORS="$(vivid generate molokai)"

# pnpm
export PNPM_HOME="/home/gaurav/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
  export DYLD_LIBRARY_PATH=/opt/homebrew/lib/
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib
	;;

Linux)
	;;
esac
