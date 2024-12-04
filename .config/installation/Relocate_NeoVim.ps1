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

# Source and target paths
$sourceNvimPath = "C:\Users\Gaurav\.nvim"
$targetNvimPath = "C:\Users\Gaurav\AppData\Local\nvim"

# Ensure the target directory exists
if (-not (Test-Path -Path $targetNvimPath)) {
    Write-Output "Creating directory for target Neovim configuration path: $targetNvimPath"
    New-Item -ItemType Directory -Path $targetNvimPath -Force
}

# Exclude the '.git' directory from being symlinked
$excludeFolders = @('.git', 'biome.json', 'README.md')

# Iterate through the source folder and create symlinks, excluding the specified folders
Get-ChildItem -Path $sourceNvimPath -Recurse | ForEach-Object {
    # Skip any excluded folders
    if ($excludeFolders -contains $_.Name) {
        Write-Host "Skipping excluded folder: $($_.FullName)"
        return
    }

    $targetFilePath = $_.FullName -replace [regex]::Escape($sourceNvimPath), $targetNvimPath
    $targetDir = [System.IO.Path]::GetDirectoryName($targetFilePath)

    # Ensure the target directory exists
    if (-not (Test-Path -Path $targetDir)) {
        Write-Output "Creating directory for target path: $targetDir"
        New-Item -ItemType Directory -Path $targetDir -Force
    }

    # Create symlink for file/directory
    if ($_ -is [System.IO.DirectoryInfo]) {
        cmd /c "mklink /D `"$targetFilePath`" `"$($_.FullName)`""
        Write-Output "Directory symlink created: $targetFilePath -> $($_.FullName)"
    } elseif ($_ -is [System.IO.FileInfo]) {
        cmd /c "mklink `"$targetFilePath`" `"$($_.FullName)`""
        Write-Output "File symlink created: $targetFilePath -> $($_.FullName)"
    }
}

Write-Host "Symlink creation complete, excluding .git folder."
