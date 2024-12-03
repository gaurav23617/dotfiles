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

# Check for existing installations using winget
function Check-IfInstalled {
    param([string]$appName)

    # Run winget to list installed packages and check if the app is installed
    $installed = winget list --id $appName
    if ($installed -ne $null -and $installed -match $appName) {
        return $true
    }

    # If not installed, return false
    return $false
}

# Ask the user if they want to install one by one or all at once
$installChoice = Read-Host "Do you want to install applications one by one or all at once? (Enter '1' for installing applications one by one or '2' for all at once)"

# Define an array of application objects (Fill this with your applications)
$applications = @(
# Utilities
[PSCustomObject]@{
    Name        = 'PowerToys'
    Command     = 'Microsoft.PowerToys'
    Category    = 'Utilities'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'Visual Studio Code'
    Command     = 'Microsoft.VisualStudioCode --override "/SILENT /mergetasks=\\"!runcode,addcontextmenufiles,addcontextmenufolders\\""'
    Category    = 'Development'
    Silent      = $true
},
[PSCustomObject]@{
    Name        = 'PowerShell'
    Command     = 'Microsoft.PowerShell'
    Category    = 'Utilities'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'Git'
    Command     = 'Git.Git'
    Category    = 'Development'
    Silent      = $false
},
# Browsers
[PSCustomObject]@{
    Name        = 'Google Chrome'
    Command     = 'Google.Chrome'
    Category    = 'Browsers'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'Zen Browser'
    Command     = 'Zen-Team.Zen-Browser.Optimized'
    Category    = 'Browsers'
    Silent      = $false
},
# Media
[PSCustomObject]@{
    Name        = 'Spotify'
    Command     = 'Spotify.Spotify'
    Category    = 'Media'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'VLC Media Player'
    Command     = 'VideoLAN.VLC'
    Category    = 'Media'
    Silent      = $false
},
# Communication
[PSCustomObject]@{
    Name        = 'Discord'
    Command     = 'Discord.Discord'
    Category    = 'Communication'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'Telegram Desktop'
    Command     = 'id Telegram.TelegramDesktop'
    Category    = 'Communication'
    Silent      = $false
},
# Utilities
[PSCustomObject]@{
    Name        = 'WinRAR'
    Command     = 'RARLab.WinRAR'
    Category    = 'Utilities'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'JetBrains Mono Nerd Font'
    Command     = 'DEVCOM.JetBrainsMonoNerdFont'
    Category    = 'Fonts'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'DevToys'
    Command     = 'DevToys-app.DevToys'
    Category    = 'Utilities'
    Silent      = $false
},
[PSCustomObject]@{
    Name        = 'Files Community'
    Command     = 'FilesCommunity.Files'
    Category    = 'Utilities'
    Silent      = $false
}
)

# Function to install with progress bar
function Install-AppWithProgress {
    param (
        [string]$appName,
        [string]$command,
        [int]$timeoutSeconds = 300  # Default timeout of 5 minutes (adjust as needed)
    )
    $progress = 0
    $totalSteps = 100  # The total number of steps for the progress bar

    Write-Host "Installing $appName..." -ForegroundColor Green

    # Start the installation process in the background
    $process = Start-Process winget -ArgumentList "install --id $command -e" -PassThru

    # Start the timer for the timeout mechanism
    $startTime = Get-Date

    # Wait for the installation to finish or timeout
    while (!$process.HasExited) {
        # Calculate the elapsed time
        $elapsedTime = (Get-Date) - $startTime

        # Check if the elapsed time exceeds the timeout
        if ($elapsedTime.TotalSeconds -ge $timeoutSeconds) {
            Write-Host "Installation of $appName timed out after $timeoutSeconds seconds." -ForegroundColor Red
            $process.Kill()  # Forcefully kill the process if it exceeds the timeout
            break
        }

        # Increment the progress
        $progress = [math]::Min($progress + 1, 100)

        # Update the progress bar
        Write-Progress -PercentComplete $progress -Activity "Installing $appName" -Status "Please wait..."

        # Small delay to make progress visible
        Start-Sleep -Seconds 1
    }

    # Ensure the progress bar reaches 100% (or stops at the maximum if it times out)
    Write-Progress -PercentComplete 100 -Activity "Installing $appName" -Status "Completed"

    # Wait for the process to fully exit if it didn't timeout
    if ($process.HasExited) {
        $process.WaitForExit()
    }

    # Optional: Check the exit code to determine success/failure
    if ($process.ExitCode -eq 0) {
        Write-Host "$appName installation completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "There was an issue installing $appName." -ForegroundColor Red
    }
}

# Install apps based on user choice
if ($installChoice -eq "2") {
    # Install all apps without prompts
    foreach ($app in $applications) {
        if (Check-IfInstalled $app.Command) {
            Write-Host "$($app.Name) is already installed. Skipping..." -ForegroundColor Yellow
        } else {
            Install-AppWithProgress $app.Name $app.Command
        }
    }
}

elseif ($installChoice -eq "1") {
    # Install apps one by one with prompts
    foreach ($app in $applications) {
        if (Check-IfInstalled $app.Command) {
            Write-Host "$($app.Name) is already installed. Skipping..." -ForegroundColor Yellow
        } else {
            $confirmation = Read-Host "Do you want to install $($app.Name)? (Y/N)"
            if ($confirmation -eq 'Y') {
                Install-AppWithProgress $app.Name $app.Command
            } else {
                Write-Host "Skipping $($app.Name)" -ForegroundColor Cyan
            }
        }
    }
}

# Function to run upgrades
function Run-Upgrades {
    Write-Host "Upgrading all installed applications..." -ForegroundColor Yellow
    Start-Process winget -ArgumentList "upgrade" -Wait
    Write-Host "Upgrade completed." -ForegroundColor Green

    Write-Host "Upgrading all applications (optional upgrade of all apps)..." -ForegroundColor Yellow
    Start-Process winget -ArgumentList "upgrade --all" -Wait
    Write-Host "All upgrades completed." -ForegroundColor Green
}

# Run upgrades after installation
Run-Upgrades

Write-Host "All applications have been installed or skipped based on your choice." -ForegroundColor Cyan
