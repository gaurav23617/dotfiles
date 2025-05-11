#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be executed as root! Exiting..."
  exit 1
fi

if [[ ! "$(grep -i nixos </etc/os-release)" ]]; then
  echo "This installation script only works on NixOS! Download an iso at https://nixos.org/download/"
  echo "Keep in mind that this script is not intended for use while in the live environment."
  exit 1
fi

if [ -f "$HOME/dotfiles/flake.nix" ]; then
  flake=$HOME/dotfiles
elif [ -f "/etc/nixos/flake.nix" ]; then
  flake=/etc/nixos
else
  echo "Error: flake not found. Ensure flake.nix exists in either \$HOME/dotfiles or /etc/nixos"
  exit 1
fi

echo -e "${GREEN}Rebuilding from $flake${NC}"
currentUser=$(logname)

sudo sed -i -e "s/username = \".*\"/username = \"$currentUser\"/" "$flake/flake.nix"

hardware_cfg_path="$flake/hosts/Default/hardware-configuration.nix"

if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
  sudo cp /etc/nixos/hardware-configuration.nix "$hardware_cfg_path"
elif [ -f "/etc/nixos/hosts/Default/hardware-configuration.nix" ]; then
  sudo cp /etc/nixos/hosts/Default/hardware-configuration.nix "$hardware_cfg_path"
else
  sudo nixos-generate-config --show-hardware-config >"$hardware_cfg_path"
fi

sudo git -C "$flake" add "hosts/Default/hardware-configuration.nix"
sudo nixos-rebuild switch --flake "$flake#Default"

echo
read -rsn1 -p"$(echo -e "${GREEN}Press any key to continue${NC}")"
