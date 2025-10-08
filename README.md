<div align="center">

# Realms (Beta)

![nixos](https://img.shields.io/badge/NixOS-24273A.svg?style=flat&logo=nixos&logoColor=4h6232)

## Yggdrasil

<img align="center" width="90%" src="https://github.com/BarryLabs/Realms/blob/main/common/yggdrasil-desktop-1.png" />

## Abyss

<img align="center" width="90%" src="https://github.com/BarryLabs/Realms/blob/main/common/abyss-desktop-1.png" />
<img align="center" width="90%" src="https://github.com/BarryLabs/Realms/blob/main/common/abyss-desktop-2.png" />

</div>

# Index

- [Abstract](#abstract)
- [Installation](#installation)
- [Featured Tools](#featured-tools)

---

# Abstract

> [!NOTE]
> Each machine is capable of handling all firmware with the current exception of _abyss_. The firmware file included seems to only work for the wifi module and not the bluetooth module.

Realms aims to automate and reduce the operational footprint of my lab with a few goals in mind;

1. Minimize proprietary software.
2. Minimize time to deploy.
3. Maximize pre-configured hardening.

- _The Proprietary_:
  For quality of life, the proprietary is limited to Nvidia GPU Drivers, Steam, Xbox Controller Drivers, Cuda Drivers and some .NET packages.
- _Time to Deploy_:
  Building a server is notoriously time-consuming and I am _lazy_. Pre-configured settings allow the workload to be put upfront...or even copied, network-targeted builds via SSH, disk and sops allow the convenience of building binaries on a stronger machine for smaller machines and generators offer easy image generation.
- _Hardening_:
  We can define our security posture prior to deployment. This is already beneficial because it directly refers to the above point but goes deeper provided conditional logic and options. For example, you have the choice to use doas or sudo-rs and both handle enabling apparmor for the respective but only if apparmor is already enabled.

---

## Installation

> [!WARNING]
> Installation won't work out of the box due to _Disko_, _Impermanence_ and/or _Sops-Nix_. These tools require tailored configurations and as such they will not work with other machines.

> [!IMPORTANT]
> The installation script should be used unless there is a remote Nix host available.

The structure of this repo is as you may expect. Machine configuration files are in the machines folder and application configuration files are somewhat organized into individual modules.

### NixOS-Anywhere

> [!IMPORTANT]
> NixOS-Anywhere is a convenient tool that enables remote building of Nix configurations via SSH. This is the preferred method of installation among environment with multiple Nix hosts.

1. Boot into any NixOS image.
2. Change password with `passwd`.
3. Check IPv4 with `ip a`.
4. Clone this repository with `git clone https://github.com/BarryLabs/realms.git` on the remote machine.
5. Check through the configuration in `./machines/${HOST}/default.nix`.
6. Apply your own SSH key within `./modules/system/com/users.nix` so you don't get locked out of your machine when it builds.
7. Use `nix run github:nix-community/nixos-anywhere -- --flake <path to flake>#<host> --target-host nixos@<ip address>` from the remote machine when you have finished making your changes.
8. Wait.

### Installation Script

> [!IMPORTANT]
> The installation script `./install.sh` should be used in all cases except where NixOS-Anywhere is used.

---

## Featured Tools

| Tool Category         | Tool(s)                           |
| --------------------- | --------------------------------- |
| AI                    | ollama                            |
| Audio Development     | ardour                            |
| Audio Effects         | easyeffects                       |
| Authentication        | keepassxc,yubikey                 |
| Automation            | n8n                               |
| Backup                | borg                              |
| Bar                   | waybar,eww                        |
| Blender               | blender                           |
| Browser               | firefox,qutebrowser               |
| CLI                   | bat,eza,cava,fzf,tealdeer,zoxide  |
| Email                 | thunderbird                       |
| File Browser          | yazi,ranger                       |
| File Sync             | syncthing,nfs,smb                 |
| FPS/Game Latency      | mangohud                          |
| Gaming                | steam,lutris                      |
| Game Streaming        | steam,sunshine                    |
| High-Availability     | podman-quadlets,k3s               |
| Logout                | wlogout                           |
| Multiplexer           | zellij,tmux,wezterm,ghostty,kitty |
| Notes                 | neorg,obsidian                    |
| Notifications         | dunst,eww                         |
| Reader                | zathura                           |
| Recording / Streaming | obs                               |
| Secrets               | sops                              |
| Screenshot            | grim,slurp                        |
| Shell                 | nushell,zsh,bash,fish             |
| System Monitor        | btop,htop                         |
| Terminal              | wezterm,ghostty,kitty,foot        |
| Text Editor           | helix,nvim,emacs                  |
| VCS                   | jujutsu,git                       |
| Video                 | mpv                               |
| Virtualisation        | podman,kvm                        |
| VR                    | alvr                              |
| Wallpaper             | hyprpaper,wpaperd,mpvpaper        |
| Window Manager        | hyprland,niri                     |
