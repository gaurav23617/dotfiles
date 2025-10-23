# Nushell Environment Config File

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    "/run/current-system/sw/bin"
    $"($env.HOME)/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
    $"($env.HOME)/.local/bin"
    "/opt/homebrew/bin"
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/.local/share/go/bin"
])

# Basic environment variables
$env.EDITOR = 'nvim'
$env.VISUAL = 'nvim'
$env.PAGER = 'less'
$env.MANPAGER = 'nvim +Man!'
$env.XDG_CONFIG_HOME = ($env.HOME | path join '.config')
$env.XDG_CACHE_HOME = ($env.HOME | path join '.cache')
$env.XDG_DATA_HOME = ($env.HOME | path join '.local/share')
$env.NU_CONFIG_DIR = ($env.HOME | path join '.config/nushell')
$env.default-config-dir = ($env.HOME | path join '.config/nushell')
$env.NU_PLUGIN_DIRS = ($env.HOME | path join '.config/nushell/plugins' '/run/current-system/sw/bin')
$env.NU_LIB_DIRS = ($env.HOME | path join '.config/nushell/scripts' '.config/nushell/completions')

# Go configuration
$env.GOPATH = ($env.HOME | path join '.local/share/go')

# Nix configuration
$env.NIX_CONFIG = "experimental-features = nix-command flakes"

$env.LS_COLORS = (vivid generate molokai)

# Prompt indicators for vi mode
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| ": " }

$env.TRANSIENT_PROMPT_COMMAND = {|| ^starship module character }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| $"(^starship module directory)(^starship module time)" }

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
$env.INITIAL_COMMIT_MSG = "The same thing we do every night, Pinky - try to take over the world!"
$env.BATMAN_INITIAL_COMMIT_MSG = "Batman! (this commit has no parents)"

if not ($nu.cache-dir | path exists) {
  mkdir $nu.cache-dir
}

zoxide init --cmd cd nushell | save --force $"($nu.cache-dir)/zoxide.nu"
starship init nu | save --force $"($nu.cache-dir)/starship.nu"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
atuin init nu | save --force $"($nu.cache-dir)/atuin.nu"

# macOS specific
if $nu.os-info.name == "macos" {
    $env.DYLD_LIBRARY_PATH = "/opt/homebrew/lib/"
    $env.DYLD_FALLBACK_LIBRARY_PATH = "/opt/homebrew/lib"
}
