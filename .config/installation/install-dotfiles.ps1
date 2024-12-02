# Clone dotfiles repository
Write-Host "Cloning dotfiles repository..."
git clone https://github.com/YourUsername/dotfiles.git $HOME\dotfiles

# Change to dotfiles directory
Set-Location $HOME\dotfiles

# Set up dotfiles (run a script if needed)
Write-Host "Setting up dotfiles..."
pwsh -Command "& ./setup-secrets.ps1"

Write-Host "Installation complete. Dotfiles and credentials are set up!"
