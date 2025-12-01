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
    #persistence."/persist/home" = {
    #  directories = [
    #    "Documents"
    #    "Downloads"
    #    "Music"
    #    "Pictures"
    #    "Projects"
    #    "Videos"
    #  ];
    #};
  };
  mods = {
    profile = {
      cli.enable = true;
      content.enable = true;
      desktop.enable = true;
      gaming.enable = true;
      security.enable = true;
    };
    gui = {
      dunst.enable = true;
      hyprlock.enable = true;
      hyprpaper.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
      wlsunset.enable = true;
    };
  };
}
