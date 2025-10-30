{ vars, ... }:
{
  imports = [
    ../../modules/home
    ../../modules/profile/home
  ];
  programs.home-manager.enable = true;
  home = {
    username = vars.user;
    homeDirectory = "/home/${vars.user}";
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = false;
  };
  mods = {
    gui = {
      dunst.enable = true;
      hyprlock.enable = true;
      hyprpaper.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
      wlsunset.enable = true;
    };
    profile = {
      cli.enable = true;
      content.enable = true;
      desktop.enable = true;
      gaming.enable = true;
      security.enable = true;
    };
  };
}
