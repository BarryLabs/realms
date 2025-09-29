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
- [Usage](#usage)
- [Featured Tools](#featured-tools)

# Abstract

> [!NOTE]
> Each machine is capable of handling all firmware with the current exception of _abyss_. The firmware file included seems to only work for the wifi module and not the bluetooth module.

Realms aims to automate and reduce the operational footprint of my lab with a few goals in mind;

1. Minimize proprietary software.
2. Minimize time to deploy.
3. Maximize pre-configured hardening.

- _The Proprietary_;
  For quality of life, the proprietary is limited to Nvidia GPU Drivers, Steam, Xbox Controller Drivers, Cuda Drivers and some .NET packages.
- _Time to Deploy_:
  Building a server is notoriously time-consuming and I am _lazy_. Pre-configured settings allow the workload to be put upfront...or even copied, network-targeted builds via SSH, disk and sops allow the convenience of building binaries on a stronger machine for smaller machines and generators offer easy image generation as another method.
- _Hardening_:
  Being atomic, we can define our security posture prior to deployment. This is already beneficial because it directly refers to the above point but goes deeper provided conditional logic and options. For example, you have the choice to use doas or sudo-rs and both handle enabling apparmor for the respective but only if apparmor is already enabled.

## Usage

There are a few options when looking at this repo. The entire configuration can be installed with a clone or even just the installation script. Both offer the choice to build any of the machines however if you dont want to build an entire configuration because you have different hardware or my config sucks, you can use this repo however you want. But let's go over how we can go about that.

---

## Featured Tools

> [!NOTE]
> The tools listed below may not necessarily come directly enabled in my configurations such as eza with nushell.

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
| Editor                | nvim,emacs,nano                   |
| Email                 | thunderbird                       |
| File Browser          | yazi,ranger                       |
| File Sync             | syncthing,nfs,smb                 |
| FPS/Game Latency      | mangohud                          |
| Gaming                | steam,lutris                      |
| Game Streaming        | steam,sunshine                    |
| High-Availability     | k3s,podman-quadlets               |
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
| Text Editor           | helix,nvim                        |
| VCS                   | jujutsu,git                       |
| Video                 | mpv                               |
| Virtualisation        | podman,kvm                        |
| VR                    | alvr                              |
| Wallpaper             | wpaperd,mpvpaper                  |
| Window Manager        | hyprland                          |

## Installation

### NixOS-Anywhere

1. Burn the Gnome ISO to a removable disk and boot into it.
2. Change password with `passwd`.
3. Be sure to check through the configuration to ensure desired configuration is
   achieved and putting in your own SSH key so you don't get locked out of your
   machine.
4. Use
   `nix run github:nix-community/nixos-anywhere -- --flake <path to flake>#<host> --target-host nixos@<ip address>`
   from the remote machine when you have finished making your changes.
5. Configure the services to run how you want them to.

### Installation Script

The install.sh script should be used if not using nixos-anywhere to install a
given machine. You must install NixOS first and then run the installation
script.
