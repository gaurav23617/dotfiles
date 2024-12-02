# Ensure the script is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Please run this script as Administrator."
    exit
}

# Define an array of commands to execute
$commands = @(
    'winget install Microsoft.PowerToys --source winget',
    'winget install Microsoft.VisualStudioCode --override "/SILENT /mergetasks=\'!runcode,addcontextmenufiles,addcontextmenufolders\'"',
    'winget install --id Microsoft.PowerShell --source winget',
    'winget install --id Microsoft.PowerShell.Preview --source winget',
    'winget install --id Git.Git -e --source winget',
    'winget install --id Starship.Starship',
    'winget install -e --id GitHub.cli',
    'winget install -e --id OpenJS.NodeJS.LTS',
    'winget install --id Zen-Team.Zen-Browser.Optimized',
    'winget install -e --id Google.Chrome',
    'winget install -e --id Klocman.BulkCrapUninstaller',
    'winget install -e --id Spotify.Spotify',
    'winget install -e --id VideoLAN.VLC',
    'winget install -e --id Discord.Discord',
    'winget install -e --id Telegram.TelegramDesktop',
    'winget install -e --id RARLab.WinRAR',
    'winget install -e --id agalwood.Motrix',
    'winget install --id DEVCOM.JetBrainsMonoNerdFont',
    'winget install -e --id JetBrains.WebStorm',
    'winget install -e --id QL-Win.QuickLook',
    'winget install --id=ModernFlyouts.ModernFlyouts -e',
    'winget install DevToys-app.DevToys',
    'winget install -e --id FilesCommunity.Files'
)

# Execute each command
foreach ($command in $commands) {
    Write-Host "Executing: $command" -ForegroundColor Green
    Invoke-Expression $command
}

Write-Host "All applications have been installed." -ForegroundColor Cyan
