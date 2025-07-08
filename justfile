# Default recipe to display help
default:
    @just --list

# Install NixOS with disko (DESTRUCTIVE - will wipe disks!)
install:
    @echo "WARNING: This will WIPE your disks!"
    @echo "Press Ctrl+C to cancel, Enter to continue..."
    @read
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/Default/disko.nix
    nixos-generate-config --root /mnt --show-hardware-config > ./hosts/Default/hardware-configuration.nix
    sudo mkdir -p /mnt/etc/nixos
    sudo cp -r . /mnt/etc/nixos/
    sudo mkdir -p /mnt/home/gaurav
    sudo cp -r . /mnt/home/gaurav/dotfiles
    sudo chown -R 1000:1000 /mnt/home/gaurav
    sudo nixos-install --flake /mnt/etc/nixos#Default --no-root-passwd
    @echo "NixOS installation complete!"

# Quick rebuild
rebuild:
    sudo nixos-rebuild switch --flake .#Default

# Test configuration without switching
test:
    sudo nixos-rebuild test --flake .#Default

# Build configuration without switching
build:
    sudo nixos-rebuild build --flake .#Default

# Update flake inputs
update:
    nix flake update

# Format nix files
fmt:
    nix fmt

# Check flake for errors
check:
    nix flake check

# Clean old generations
clean:
    sudo nix-collect-garbage -d
    sudo nix-env --delete-generations +7 -p /nix/var/nix/profiles/system

# Show system generations
generations:
    sudo nix-env -p /nix/var/nix/profiles/system --list-generations

# Show disk layout before installation
check-disks:
    @echo "Current disk layout:"
    @lsblk
