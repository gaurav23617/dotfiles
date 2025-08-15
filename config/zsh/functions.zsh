if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function zoxide_fzf() {
    local orig_buffer=$LBUFFER
    local selection
    selection=$(zoxide query --list | fzf --height 40% --reverse --border) || {
        LBUFFER=$orig_buffer
        zle redisplay
        return 0
    }

    if [[ -n "$selection" ]]; then
        LBUFFER+="$selection"
        zle redisplay
    fi
}

# Direnv hook
eval "$(direnv hook zsh)"

# Base URL for the templates
NIX_TEMPLATE_URL="https://flakehub.com/f/the-nix-way/dev-templates/*"

# Initialize the current directory with a template
function nix-init {
  local template="${1:-empty}"
  nix flake init --template "$NIX_TEMPLATE_URL#$template"
  direnv allow
}

# Create a new project with a template
function nix-new {
  local dir="$1"
  local template="${2:-empty}"
  
  if [[ -z "$dir" ]]; then
    echo "Usage: nix-new <directory> [template]"
    echo "Example: nix-new my-project node"
    return 1
  fi
  
  if [[ -d "$dir" ]]; then
    echo "Directory \"$dir\" already exists!"
    return 1
  fi
  
  nix flake new "$dir" --template "$NIX_TEMPLATE_URL#$template"
  cd "$dir"
  direnv allow
}

# function sesh-sessions() {
#   {
#     exec </dev/tty
#     exec <&1
#     local session
#     session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
#     [[ -z "$session" ]] && return
#     sesh connect $session
#   }
# }

