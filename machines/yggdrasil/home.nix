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
    profile = {
      cli.enable = true;
      content.enable = true;
      desktop.enable = true;
      gaming.enable = true;
      security.enable = true;
    };
    gui = {
      dunst.enable = true;
      eww.enable = true;
      fuzzel.enable = true;
      hyprpaper.enable = true;
    };
  };
}
