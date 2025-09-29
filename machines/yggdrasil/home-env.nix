{ pkgs, ... }:
{
  programs = {
    home-manager = {
      enable = true;
    };
  };
  home = {
    username = "chandler";
    homeDirectory = "/home/chandler";
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;
    sessionVariables = { };
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
