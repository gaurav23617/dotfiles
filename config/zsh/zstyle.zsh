# ⚡ Completion system setup
autoload -Uz compinit

# Use a persistent, fast zcompdump location
ZCDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

# Load cached completions
if [[ ! -s "$ZCDUMP" || "$ZCDUMP" -ot ~/.zshrc ]]; then
  compinit -d "$ZCDUMP"
else
  compinit -C -d "$ZCDUMP"
fi

# Precompile zcompdump for faster startups
if [[ -s "$ZCDUMP" && (! -s "$ZCDUMP.zwc" || "$ZCDUMP" -nt "$ZCDUMP.zwc") ]]; then
  zcompile "$ZCDUMP"
fi

# 🧠 Completion styling
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# fzf-tab specific previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
