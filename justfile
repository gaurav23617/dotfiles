# Default recipe to display help
default:
    @just --list

# Install NixOS with disko (DESTRUCTIVE - will wipe disks!)
install-nixos hostname:
    @echo "⚠️  WARNING: This will WIPE your disks! Press Ctrl+C to cancel, Enter to continue..."
    @read
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko.nix
    nixos-generate-config --root /mnt
    sudo cp -r . /mnt/etc/nixos/
    sudo nixos-install --flake /mnt/etc/nixos#{{hostname}}

# Rebuild NixOS system
rebuild hostname:
    sudo nixos-rebuild switch --flake .#{{hostname}}

# Test NixOS configuration without switching
test hostname:
    sudo nixos-rebuild test --flake .#{{hostname}}

# Build NixOS configuration without switching
build hostname:
    sudo nixos-rebuild build --flake .#{{hostname}}

# Update flake inputs
update:
    nix flake update

# Update specific input
update-input input:
    nix flake lock --update-input {{input}}

# Apply home-manager configuration
home-switch user hostname:
    home-manager switch --flake .#{{user}}@{{hostname}}

# Format nix files
fmt:
    nix fmt

# Check flake
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

# Example commands for your specific setup:
# Install on coffee machine
install-coffee:
    just install-nixos coffee

# Install on VM
install-vm:
    just install-nixos vm

# Rebuild coffee
rebuild-coffee:
    just rebuild coffee

# Rebuild VM
rebuild-vm:
    just rebuild vm

# Switch home-manager for gaurav on coffee
home-coffee:
    just home-switch gaurav coffee

# Switch home-manager for gaurav on VM
home-vm:
    just home-switch gaurav vm
