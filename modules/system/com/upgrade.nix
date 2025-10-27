{ config
, lib
, ...
}:
with lib;
let
  module = "upgrade";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Upgrade Module";
  config = mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      dates = "weekly";
      flake = "/etc/nixos";
      operation = "switch";
      flags = [
        "--update-input"
        "nixpkgs"
        "--update-input"
        "home-manager"
        "--update-input"
        "sops-nix"
        "--update-input"
        "disko"
        "--update-input"
        "impermanence"
        "--update-input"
        "nixos-generators"
        # "--update-input"
        # "nix-minecraft"
        "--commit-lock-file"
      ];
    };
  };
}
