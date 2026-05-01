{
  flake.nixosModules.wezterm = {pkgs, ...}: {
    environment.systemPackages = [pkgs.wezterm];
  };
  flake.homeModules.wezterm = {pkgs, ...}: {
    home.packages = with pkgs; [
      wezterm
    ];
  };
}
