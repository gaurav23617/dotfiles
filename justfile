# Default recipe to display help
default:
    @just --list

# Install NixOS with disko for coffee (DESTRUCTIVE - will wipe disks!)
install-coffee:
    @echo "⚠️  WARNING: This will WIPE your disks for coffee machine!"
    @echo "Press Ctrl+C to cancel, Enter to continue..."
    @read
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./host/coffee/disk.nix
    nixos-generate-config --root /mnt
    sudo mkdir -p /mnt/home/gaurav
    sudo cp -r . /mnt/home/gaurav/dotfiles
    sudo nixos-install --flake /mnt/home/gaurav/dotfiles#coffee
    @echo "🎉 NixOS installation complete! After reboot, run: cd ~/dotfiles && just setup-home-coffee"

# Install NixOS with disko for VM (DESTRUCTIVE - will wipe disks!)
install-vm:
    @echo "⚠️  WARNING: This will WIPE your disks for VM!"
    @echo "Press Ctrl+C to cancel, Enter to continue..."
    @read
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./host/vm/disk.nix
    nixos-generate-config --root /mnt
    sudo mkdir -p /mnt/home/gaurav
    sudo cp -r . /mnt/home/gaurav/dotfiles
    sudo nixos-install --flake /mnt/home/gaurav/dotfiles#vm
    @echo "🎉 NixOS installation complete! After reboot, run: cd ~/dotfiles && just setup-home-vm"

# Quick rebuild shortcuts
coffee:
    sudo nixos-rebuild switch --flake .#coffee

vm:
    sudo nixos-rebuild switch --flake .#vm

# Test configurations without switching
test-coffee:
    sudo nixos-rebuild test --flake .#coffee

test-vm:
    sudo nixos-rebuild test --flake .#vm

# Build configurations without switching
build-coffee:
    sudo nixos-rebuild build --flake .#coffee

build-vm:
    sudo nixos-rebuild build --flake .#vm

# First-time setup after fresh installation
setup-home-coffee:
    @echo "🏠 Setting up home-manager for coffee..."
    home-manager switch --flake .#gaurav@coffee
    @echo "✅ Home-manager setup complete for coffee!"

setup-home-vm:
    @echo "🏠 Setting up home-manager for VM..."
    home-manager switch --flake .#gaurav@vm
    @echo "✅ Home-manager setup complete for VM!"

# Home-manager shortcuts
home-coffee:
    home-manager switch --flake .#gaurav@coffee

home-vm:
    home-manager switch --flake .#gaurav@vm

# Full system update (flake + rebuild + home-manager)
full-coffee:
    nix flake update
    sudo nixos-rebuild switch --flake .#coffee
    home-manager switch --flake .#gaurav@coffee

full-vm:
    nix flake update
    sudo nixos-rebuild switch --flake .#vm
    home-manager switch --flake .#gaurav@vm

# Update flake inputs
update:
    nix flake update

# Update specific input
update-input input:
    nix flake lock --update-input {{input}}

# Format nix files
fmt:
    nix fmt

# Check flake for errors
check:
    nix flake check

# Clean old generations (keep last 7)
clean:
    sudo nix-collect-garbage -d
    sudo nix-env --delete-generations +7 -p /nix/var/nix/profiles/system
    nix-env --delete-generations +7

# Show system generations
generations:
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations

# Boot into previous generation
rollback:
    sudo nixos-rebuild switch --rollback

# Development shell
dev:
    nix develop

# Show flake info
info:
    nix flake metadata

# Show disk usage
disk-usage:
    sudo du -sh /nix/store
    sudo du -sh /nix/var/nix/profiles/

# Optimize nix store
optimize:
    sudo nix-store --optimize

# Show what's in the current generation
show-config:
    nix show-config

# Diff between generations
diff-gens old new:
    nix profile diff-closures --profile /nix/var/nix/profiles/system/{{old}}-link /nix/var/nix/profiles/system/{{new}}-link

# Edit specific config files quickly
edit-coffee-config:
    $EDITOR host/coffee/configuration.nix

edit-vm-config:
    $EDITOR host/vm/configuration.nix

edit-coffee-home:
    $EDITOR host/coffee/home.nix

edit-vm-home:
    $EDITOR host/vm/home.nix

edit-coffee-disk:
    $EDITOR host/coffee/disk.nix

edit-vm-disk:
    $EDITOR host/vm/disk.nix

# Git shortcuts for your dotfiles
git-push:
    git add .
    git commit -m "Update dotfiles"
    git push

# Backup current config before major changes
backup:
    cp -r . ~/dotfiles-backup-$(date +%Y%m%d-%H%M%S)
    @echo "Backup created in ~/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Check syntax of all nix files
check-syntax:
    find . -name "*.nix" -exec nix-instantiate --parse {} \; > /dev/null

# Show flake inputs
show-inputs:
    nix flake metadata --json | jq '.locks.nodes | to_entries[] | select(.key != "root") | {(.key): .value.locked}'
