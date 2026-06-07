<div align="center">

# Realms

![nixos](https://img.shields.io/badge/NixOS-24273A.svg?style=flat&logo=nixos&logoColor=4h6232)

</div>

---

# Abstract

Realms aims to automate and reduce the operational footprint of my lab with a few goals in mind;

- _The Proprietary_:
  For quality of life, the proprietary is limited to Nvidia GPU Drivers, Steam, Xbox Controller Drivers, Cuda Drivers and some .NET packages.
- _Time to Deploy_:
  Building a server is notoriously time-consuming and I am _lazy_. Pre-configured settings allow the workload to be put upfront...or even copied, network-targeted builds via SSH, disk and sops allow the convenience of building binaries on a stronger machine for smaller machines and generators offer easy image generation.
- _Hardening_:
  We can define our security posture prior to deployment. This is already beneficial because it directly refers to the above point but goes deeper provided conditional logic and options. For example, you have the choice to use doas or sudo-rs and both handle enabling apparmor.
- _Modularity_:
  Each module handles all necessary configurations. Modules have been sorted by type so if you want to see my hosts...it's probably in the hosts folder. Machine specific configuration lies in the host configuration.
  
---

## Featured Tools

| Tool Category         | Tool(s)                           |
| --------------------- | --------------------------------- |
| AI                    | ollama,opencode,goose             |
| Audio Development     | ardour                            |
| Audio Effects         | easyeffects                       |
| Authentication        | keepassxc,yubikey                 |
| Automation            | n8n                               |
| Backup                | borg                              |
| Bar                   | noctalia,waybar                   |
| Blender               | blender                           |
| Browser               | firefox,qutebrowser               |
| CLI                   | bat,eza,cava,fzf,fd,zoxide,dust   |
| Email                 | thunderbird                       |
| Fan Control           | coolercontrol                     |
| File Browser          | yazi,ranger                       |
| File Sync             | syncthing,nfs,smb                 |
| FPS/Game Latency      | mangohud                          |
| Gaming                | steam,lutris                      |
| Game Streaming        | steam,sunshine                    |
| High-Availability     | podman,k3s                        |
| Logout                | noctalia,wlogout                  |
| Multiplexer           | zellij,tmux,wezterm,ghostty,kitty |
| Notes                 | neorg,obsidian                    |
| Notifications         | noctalia,dunst,eww                |
| Reader                | zathura                           |
| Recording / Streaming | obs                               |
| Secrets               | sops                              |
| Screenshot            | grim,slurp                        |
| Shell                 | nushell,zsh,bash,fish             |
| "Shell"               | quickshell,eww                    |
| System Monitor        | btop,htop                         |
| Terminal              | wezterm,ghostty,kitty,foot        |
| Text Editor           | helix,nvim,emacs                  |
| VCS                   | jujutsu,git                       |
| Video                 | mpv                               |
| Virtualisation        | podman,kvm                        |
| VR                    | alvr                              |
| Wallpaper             | hyprpaper,wpaperd,mpvpaper        |
| Window Manager        | mango,niri,hyprland               |
