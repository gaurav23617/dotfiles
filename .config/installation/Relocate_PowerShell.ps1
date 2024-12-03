# Ensure the script is running as Administrator
function Ensure-Admin {
    # Load the necessary assembly for MessageBox
    Add-Type -AssemblyName PresentationFramework

    # Check if the script is running as Administrator
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        $message = "This script needs to be run as Administrator. Would you like to run this script as Administrator?"
        $caption = "Administrator Privileges Required"
        $result = [System.Windows.MessageBox]::Show($message, $caption, [System.Windows.MessageBoxButton]::YesNo, [System.Windows.MessageBoxImage]::Warning)

        if ($result -eq [System.Windows.MessageBoxResult]::Yes) {
            # Get the full path to the current script
            $scriptPath = $PSCommandPath

            # Start PowerShell as Administrator and run the script
            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
            exit
        } else {
            Write-Host "Administrator privileges are required. Exiting script."
            exit
        }
    }
}

# Check if the script is being run as administrator
# If not, elevate to administrator
if (-not $env:IS_ELEVATED) {
    $env:IS_ELEVATED = "True"
    Ensure-Admin
}

# Use USERPROFILE as a fallback for HOME
if (-not $env:HOME) {
    $env:HOME = $env:USERPROFILE
}

# Original locations of the profile files
$originalVSCodeProfilePath = Join-Path $env:USERPROFILE "Documents\PowerShell\Microsoft.VSCode_profile.ps1"
$originalPowerShellProfilePath = Join-Path $env:USERPROFILE "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

# New locations where actual profile files will be created
$newVSCodeProfilePath = Join-Path $env:HOME ".pwsh\Microsoft.VSCode_profile.ps1"
$newPowerShellProfilePath = Join-Path $env:HOME ".pwsh\Microsoft.PowerShell_profile.ps1"

# Validate the resolved HOME path
if (-not (Test-Path -Path $env:HOME)) {
    Write-Error "Environment variable HOME is not set or points to an invalid path: $env:HOME"
    return
}

# Ensure the directory for the new profile files exists (in .pwsh)
$newProfileDirectory = [System.IO.Path]::GetDirectoryName($newPowerShellProfilePath)
if (-not (Test-Path -Path $newProfileDirectory)) {
    Write-Output "Creating directory for new profile path: $newProfileDirectory"
    New-Item -ItemType Directory -Path $newProfileDirectory -Force
}

$newVSCodeProfileDirectory = [System.IO.Path]::GetDirectoryName($newVSCodeProfilePath)
if (-not (Test-Path -Path $newVSCodeProfileDirectory)) {
    Write-Output "Creating directory for VSCode profile path: $newVSCodeProfileDirectory"
    New-Item -ItemType Directory -Path $newVSCodeProfileDirectory -Force
}

# Ensure the target files (in .pwsh) exist for both profiles
if (-not (Test-Path -Path $newVSCodeProfilePath)) {
    Write-Error "Target file for Microsoft.VSCode_profile.ps1 does not exist: $newVSCodeProfilePath"
    return
}

if (-not (Test-Path -Path $newPowerShellProfilePath)) {
    Write-Error "Target file for Microsoft.PowerShell_profile.ps1 does not exist: $newPowerShellProfilePath"
    return
}

# Remove existing symlink files in Documents\PowerShell (if they exist)
if (Test-Path -Path $originalVSCodeProfilePath) {
    Write-Output "Removing existing VSCode profile file at the symlink location: $originalVSCodeProfilePath"
    Remove-Item -Path $originalVSCodeProfilePath -Force
}

if (Test-Path -Path $originalPowerShellProfilePath) {
    Write-Output "Removing existing PowerShell profile file at the symlink location: $originalPowerShellProfilePath"
    Remove-Item -Path $originalPowerShellProfilePath -Force
}

# Create the symbolic link for Microsoft.VSCode_profile.ps1
cmd /c "mklink `"$originalVSCodeProfilePath`" `"$newVSCodeProfilePath`""
Write-Output "Symbolic link created: $originalVSCodeProfilePath -> $newVSCodeProfilePath"

# Create the symbolic link for Microsoft.PowerShell_profile.ps1
cmd /c "mklink `"$originalPowerShellProfilePath`" `"$newPowerShellProfilePath`""
Write-Output "Symbolic link created: $originalPowerShellProfilePath -> $newPowerShellProfilePath"
