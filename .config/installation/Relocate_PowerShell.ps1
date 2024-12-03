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

# Use USERPROFILE as a fallback for HOME if it's not set
if (-not $env:HOME) {
    $env:HOME = $env:USERPROFILE
}

# Locate the PowerShell profile path
$profilePath = $PROFILE

# New location for Microsoft.PowerShell_profile.ps1
$newProfilePath = Join-Path $env:HOME ".pwsh\Microsoft.PowerShell_profile.ps1"

# Path for the VSCode profile
$vscodeProfilePath = "C:\Users\Gaurav\Documents\PowerShell\Microsoft.VSCode_profile.ps1"

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

# Ensure the VSCode profile path exists
if (-not (Test-Path -Path $vscodeProfilePath)) {
    Write-Error "VSCode profile path does not exist: $vscodeProfilePath"
    return
}

# Remove the existing profile file if it exists and create a symbolic link for PowerShell profile
if (Test-Path -Path $profilePath) {
    Remove-Item -Path $profilePath -Force
}

# Create a symbolic link for the PowerShell profile
cmd /c "mklink `"$profilePath`" `"$newProfilePath`""
Write-Output "Symbolic link created: $profilePath -> $newProfilePath"

# Define path for VSCode profile symbolic link
$vscodeProfileLink = Join-Path $env:HOME ".pwsh\Microsoft.VSCode_profile.ps1"

# Remove the existing VSCode profile link if it exists
if (Test-Path -Path $vscodeProfileLink) {
    Remove-Item -Path $vscodeProfileLink -Force
}

# Create a symbolic link for VSCode profile
cmd /c "mklink `"$vscodeProfileLink`" `"$vscodeProfilePath`""
Write-Output "Symbolic link created: $vscodeProfileLink -> $vscodeProfilePath"
