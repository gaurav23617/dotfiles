# Default recipe to display help
default:
    @just --list

# Install NixOS with disko for coffee (DESTRUCTIVE - will wipe disks!)
install-coffee:
    @echo "⚠️  WARNING: This will WIPE your disks for coffee machine!"
    @echo "This will format /dev/nvme0n1 (home) and /dev/nvme1n1 (root/boot/swap)"
    @echo "Press Ctrl+C to cancel, Enter to continue..."
    @read
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./host/coffee/disk.nix
    nixos-generate-config --root /mnt
    sudo nixos-install --flake .#coffee
    @echo "🎉 NixOS installation complete!"
    @echo "After reboot, manually copy your dotfiles and run: just setup-home-coffee"

# Quick rebuild shortcuts
coffee:
    sudo nixos-rebuild switch --flake .#coffee

# Test configurations without switching
test-coffee:
    sudo nixos-rebuild test --flake .#coffee


# Build configurations without switching
build-coffee:
    sudo nixos-rebuild build --flake .#coffee

# Full system update (flake + rebuild + home-manager)
full-coffee:
    nix flake update
    sudo nixos-rebuild switch --flake .#coffee

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

# Check disk layout before installation
check-disks:
    @echo "Current disk layout:"
    @lsblk
    @echo ""
    @echo "⚠️  Disko will format these disks:"
    @echo "  /dev/nvme0n1 -> /home (btrfs)"
    @echo "  /dev/nvme1n1 -> /boot (8G), swap (16G), / (remaining)"

# Verify disko configuration
verify-disko:
    @echo "Verifying disko configuration..."
    nix eval --impure --expr '(import ./host/coffee/disk.nix).disko.devices'
