#!/bin/sh

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^k' history-substring-backward
bindkey '^j' atuin-up-search
bindkey '^r' atuin-search
bindkey '^[w' kill-region
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s ^f "tmux-sessionizer\n"
# bindkey -M vicmd 'k' history-substring-backward
# bindkey -M vicmd 'j' history-substring-search-down
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
