{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.nix;
in
{
  options.augs.com.nix.enable = mkEnableOption "Base Nix Module";
  config = mkIf cfg.enable {
    nix = {
      # gc = {
      #   automatic = true;
      #   options = lib.mkDefault "--delete-older-than 7d";
      #   dates = lib.mkDefault "weekly";
      # };
      settings = {
        auto-optimise-store = true;
        allowed-users = [
          "root"
          "@wheel"
        ];
        cores = lib.mkDefault 8;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
    };
  };
}
