# Nushell Environment Config File

# Set config directory FIRST before anything else uses it
$env.NU_CONFIG_DIR = ($env.HOME | path join '.config/nushell')
$env.NU_LIB_DIRS = [($env.HOME | path join '.config/nushell/scripts'), ($env.HOME | path join '.config/nushell/completions')]
$env.NU_PLUGIN_DIRS = [($env.HOME | path join '.config/nushell/plugins'), '/run/current-system/sw/bin']

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    "/run/current-system/sw/bin"
    $"($env.HOME)/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    $"($env.HOME)/.local/bin"
    "/opt/homebrew/bin"
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/.local/share/go/bin"
])

# XDG Base Directory specification
$env.XDG_CONFIG_HOME = ($env.HOME | path join '.config')
$env.XDG_CACHE_HOME = ($env.HOME | path join '.cache')
$env.XDG_DATA_HOME = ($env.HOME | path join '.local/share')

# Editor configuration
$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'
$env.PAGER = 'less'
$env.MANPAGER = 'nvim +Man!'

# Go configuration
$env.GOPATH = ($env.HOME | path join '.local/share/go')

# Nix configuration
$env.NIX_CONFIG = "experimental-features = nix-command flakes"

# Colors for ls
$env.LS_COLORS = (vivid generate molokai)

# Starship prompt indicators for vi mode
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| ": " }
$env.TRANSIENT_PROMPT_COMMAND = {|| ^starship module character }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| $"(^starship module directory)(^starship module time)" }

# Carapace bridge configuration
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# Custom commit messages
$env.INITIAL_COMMIT_MSG = "The same thing we do every night, Pinky - try to take over the world!"
$env.BATMAN_INITIAL_COMMIT_MSG = "Batman! (this commit has no parents)"

# Ensure cache directory exists
if not ($nu.cache-dir | path exists) {
  mkdir $nu.cache-dir
}

# Initialize tool integrations
zoxide init --cmd cd nushell | save --force $"($nu.cache-dir)/zoxide.nu"
starship init nu | save --force $"($nu.cache-dir)/starship.nu"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
atuin init nu | save --force $"($nu.cache-dir)/atuin.nu"

# macOS specific
if $nu.os-info.name == "macos" {
    $env.DYLD_LIBRARY_PATH = "/opt/homebrew/lib/"
    $env.DYLD_FALLBACK_LIBRARY_PATH = "/opt/homebrew/lib"
}
