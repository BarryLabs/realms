{
  flake.nixosModules.emacs = {pkgs, ...}: {
    environment = {
      sessionVariables = {
        "PATH" = "$HOME/.config/emacs/bin:$PATH";
      };
      systemPackages = [pkgs.emacs];
    };
  };
  flake.homeModules.emacs = {pkgs, ...}: {
    home.packages = with pkgs; [
      emacs
    ];
  };
}
