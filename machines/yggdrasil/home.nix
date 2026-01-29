{ vars, ... }:
{
  imports = [
    ../../modules/home
    ../../profiles/home
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
      crypto.enable = true;
      desktop.enable = true;
      gaming.enable = true;
      programming.enable = true;
      security.enable = true;
    };
    gui = {
      dunst.enable = true;
      fuzzel.enable = true;
      hyprland.enable = true;
      hyprpaper.enable = true;
      quickshell.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
    };
  };
}
