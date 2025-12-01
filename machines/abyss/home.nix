{
  imports = [
    ../../modules/home
    ../../modules/profile/home
  ];
  programs.home-manager.enable = true;
  home =
    let
      user = "mamotdask";
    in
    {
      username = user;
      homeDirectory = "/home/${user}";
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
      hyprland.enable = true;
      hyprpaper.enable = true;
      rofi.enable = true;
      wlogout.enable = true;
      wlsunset.enable = true;
    };
  };
}
