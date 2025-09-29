{ pkgs
, ...
}:
{
  programs = {
    home-manager = {
      enable = true;
    };
  };
  home = {
    username = "mamotdask";
    homeDirectory = "/home/mamotdask";
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;
    packages = with pkgs; [
      # Dependencies
      jq
      socat
      grim
      slurp
      swappy
      ydotool
      mpvpaper
      hyprpicker
      wl-clipboard

      # Apps
      obsidian
      gimp
      ardour
      blender
      keepassxc
      runelite
      libreoffice
      monero-gui
      vesktop

    ];
  };
}
