# Use USERPROFILE as a fallback for HOME
if (-not $env:HOME) {
    $env:HOME = $env:USERPROFILE
}

# Locate the PowerShell profile path
$profilePath = $PROFILE

# New location for Microsoft.PowerShell_profile.ps1
$newProfilePath = Join-Path $env:HOME ".pwsh\Microsoft.PowerShell_profile.ps1"

# Validate the resolved HOME path
if (-not (Test-Path -Path $env:HOME)) {
    Write-Error "Environment variable HOME is not set or points to an invalid path: $env:HOME"
    return
}

# Ensure the new profile path exists
if (-not (Test-Path -Path $newProfilePath)) {
    Write-Error "New profile path does not exist: $newProfilePath"
    return
}

# Remove the existing profile file if it exists and create a symbolic link
if (Test-Path -Path $profilePath) {
    Remove-Item -Path $profilePath -Force
}

cmd /c "mklink `"$profilePath`" `"$newProfilePath`""
Write-Output "Symbolic link created: $profilePath -> $newProfilePath"
