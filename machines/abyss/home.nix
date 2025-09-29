{
  imports = [
    ./home-env.nix
    ../../modules/home
  ];
  mods = {
    wm = {
      wayland = {
        dunst.abyss.enable = true;
        hypridle.abyss.enable = true;
        hyprland.abyss.enable = true;
        hyprlock.abyss.enable = true;
        rofi.abyss.enable = true;
        waybar.abyss.enable = true;
        wlogout.abyss.enable = true;
        wlsunset.abyss.enable = true;
        wpaperd.abyss.enable = true;
      };
    };
    terminal = {
      wezterm.base.enable = true;
    };
    cli = {
      bat.base.enable = true;
      cava.base.enable = true;
      eza.base.enable = true;
      fastfetch.base.enable = true;
      fzf.base.enable = true;
      git.base.enable = true;
      helix.base.enable = true;
      jujutsu.base.enable = true;
      nushell.base.enable = true;
      starship.base.enable = true;
      tealdeer.base.enable = true;
      yazi.base.enable = true;
      zellij.base.enable = true;
      zoxide.base.enable = true;
      zsh.base.enable = true;
    };
    browser = {
      chromium.base.enable = false;
      firefox.base.enable = true;
      qutebrowser.base.enable = true;
    };
    tools = {
      btop.base.enable = true;
      easyeffects.base.enable = true;
      lutris.adwaita.enable = true;
      mangohud.base.enable = true;
      mpv.base.enable = true;
      obs.wayland.enable = true;
      ollama.nvidia.enable = false;
      podman.base.enable = true;
      thunderbird.base.enable = true;
      zathura.base.enable = true;
    };
  };
}
