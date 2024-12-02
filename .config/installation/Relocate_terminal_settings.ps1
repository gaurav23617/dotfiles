# Fallback to USERPROFILE if HOME is not set
if (-not $env:HOME -or [string]::IsNullOrWhiteSpace($env:HOME)) {
    $env:HOME = $env:USERPROFILE
}

# Locate Windows Terminal settings
$localAppData = $env:LOCALAPPDATA
$packagesPath = Join-Path $localAppData "Packages"
$terminalFolder = Get-ChildItem -Path $packagesPath -Filter "Microsoft.WindowsTerminal_*" | Select-Object -First 1

# Check if Windows Terminal folder is found
if (-not $terminalFolder) {
    Write-Error "Windows Terminal folder could not be found in $packagesPath."
    return
}

$terminalSettingsPath = Join-Path $terminalFolder.FullName "LocalState\settings.json"

# New location for settings.json
$newSettingsPath = Join-Path $env:HOME "terminal-settings.json"

# Validate the resolved HOME path
if (-not (Test-Path -Path $env:HOME)) {
    Write-Error "Environment variable HOME is not set or points to an invalid path: $env:HOME"
    return
}

# Ensure the new settings path exists
if (-not (Test-Path -Path $newSettingsPath)) {
    Write-Error "New terminal settings.json path does not exist: $newSettingsPath"
    return
}

# Remove the existing settings file and create a symbolic link
if (Test-Path -Path $terminalSettingsPath) {
    Remove-Item -Path $terminalSettingsPath -Force
}

# Create symbolic link
$cmdOutput = cmd /c "mklink `"$terminalSettingsPath`" `"$newSettingsPath`""
if ($LASTEXITCODE -eq 0) {
    Write-Output "Symbolic link created: $terminalSettingsPath -> $newSettingsPath"
} else {
    Write-Error "Failed to create symbolic link. Error: $cmdOutput"
}
