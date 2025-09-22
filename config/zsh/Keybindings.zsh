#!/bin/sh

# Keybindings

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s ^f "tmux-sessionizer\n"
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export VI_MODE_ESC_INSERT="jk" && plug "zap-zsh/vim"
export VI_MODE_ESC_INSERT="jj" && plug "zap-zsh/vim"
