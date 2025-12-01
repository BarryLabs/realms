#!/usr/bin/env bash

if [ -n "$(grep -i nixos </etc/os-release)" ]; then
  echo "Beginning installation..."
else
  echo "Boot into nixos in order to use the installation script."
  exit
fi
echo "Proceeding with Git check."
if command -v git &>/dev/null; then
  echo "Git located. Proceeding with installation."
else
  nix-shell -p git
fi
sleep 0.1
cd || return
git clone https://github.com/BarryLabs/realms.git
cd realms || return
read -rp "Options:
------------
[ abyss ]
aegir
asgard
bifrost
heimskringla
hel
himinbjorg
jotunheim
mini-iso
mini-vm
muspelheim
tesseract
valaskjalf
valhalla
yggdrasil
------------


Please enter the name of the desired configuration: " host
if [ -z "$host" ]; then
  host="abyss"
fi
echo "--------"
echo "Generating hardware configuration..."
echo "--------"
sudo nixos-generate-config --show-hardware-config >./machines/$host/hardware-configuration.nix
echo "Altering ${host} references..."
echo "--------"
sed -i 's/disko/hardware-configuration/g' ./machines/$host/default.nix
NIX_CONFIG="experimental-features = nix-command flakes"
echo "Moving files into /etc/nixos..."
echo "--------"
sudo cp -r ~/realms/* /etc/nixos/
sudo cp -r ~/realms/.* /etc/nixos/
echo "Building $host..."
echo "--------"
sudo nixos-rebuild switch --flake ~/realms/#$host
sudo rm -rf ~/realms
