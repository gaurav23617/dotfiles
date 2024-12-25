#!/bin/sh

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
