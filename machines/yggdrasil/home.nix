{
  imports = [
    ../../modules/home
    ../../modules/profile/home
  ];
  programs.home-manager.enable = true;
  home =
    let
      user = "chandler";
    in
    {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "25.11";
      enableNixpkgsReleaseCheck = false;
    };
  mods = {
    wm = {
      wayland = {
        dunst.yggdrasil.enable = true;
        hyprlock.yggdrasil.enable = true;
        hyprpaper.yggdrasil.enable = true;
        rofi.yggdrasil.enable = true;
        waybar.yggdrasil.enable = true;
        wlogout.yggdrasil.enable = true;
        wlsunset.yggdrasil.enable = true;
      };
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
