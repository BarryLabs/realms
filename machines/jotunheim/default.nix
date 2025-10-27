{ pkgs, ... }:
{
  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
    termux-setup-storage.enable = true;
    xdg-open.enable = true;
  };
  environment = {
    etcBackupExtension = ".bak";
    packages = with pkgs; [
      nano
      vim
    ];
  };
  # home-manager = {
  #   config = ./home.nix;
  #   useGlobalPkgs = true;
  #   backupFileExtension = "hm-bak";
  # };
  nix.extraOptions = ''
    experimental-feature = nix-command flakes
  '';
  user = {
    userName = "mamot";
  };
  system.stateVersion = "24.05";
  time.timeZone = "US/Eastern";
  terminal = {
    font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/FiraCodeNerdFont-Regular.ttf";
    colors = {
      background = "#000000";
      foreground = "#c1c1c1";
      cursor = "#c1c1c1";
      color0 = "#000000";
      color1 = "#5f8787";
      color2 = "#d0dfee";
      color3 = "#5f81a5";
      color4 = "#888888";
      color5 = "#999999";
      color6 = "#aaaaaa";
      color7 = "#c1c1c1";
      color8 = "#333333";
      color9 = "#5f8787";
      color10 = "#d0dfee";
      color11 = "#5f81a5";
      color12 = "#888888";
      color13 = "#999999";
      color14 = "#aaaaaa";
      color15 = "#c1c1c1";
    };
  };
}
