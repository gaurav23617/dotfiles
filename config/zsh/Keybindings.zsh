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

function sesh-sessions-widget() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh sessions ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect "$session"
  }
}
zle -N sesh-sessions-widget

function sesh-zoxide-widget() {
  {
    exec </dev/tty
    exec <&1
    local session
    # -i removed to fix connection string issues
    session=$(sesh list -H -z | fzf --height 40% --reverse --border-label ' sesh zoxide ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect "$session"
  }
}
zle -N sesh-zoxide-widget

# Bind after zsh-vi-mode init
zvm_after_init_commands+=('bindkey "^f" sesh-zoxide-widget')
zvm_after_init_commands+=('bindkey "^[f" sesh-zoxide-widget')
zvm_after_init_commands+=('bindkey "^s" sesh-sessions-widget')
zvm_after_init_commands+=('bindkey "^[s" sesh-sessions-widget')

zvm_after_init_commands+=('bindkey -M viins "^f" sesh-zoxide-widget')
zvm_after_init_commands+=('bindkey -M viins "^[f" sesh-zoxide-widget')
zvm_after_init_commands+=('bindkey -M viins "^s" sesh-sessions-widget')
zvm_after_init_commands+=('bindkey -M viins "^[s" sesh-sessions-widget')

zvm_after_init_commands+=('bindkey -M vicmd "^f" sesh-zoxide-widget')
zvm_after_init_commands+=('bindkey -M vicmd "^[f" sesh-zoxide-widget')
zvm_after_init_commands+=('bindkey -M vicmd "^s" sesh-sessions-widget')
zvm_after_init_commands+=('bindkey -M vicmd "^[s" sesh-sessions-widget')

# bindkey -M vicmd 'k' history-substring-backward
# bindkey -M vicmd 'j' history-substring-search-down
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
