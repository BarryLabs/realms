{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.bash;
in
{
  options.augs.com.bash.enable = mkEnableOption "Base Bash Module";
  config = mkIf cfg.enable {
    programs.bash = {
      completion = {
        enable = true;
      };
      shellAliases = lib.mkDefault {
        c = "clear";
        h = "history";
        nr = "sudo nixos-rebuild switch";
        nc = "sudo nix-collect-garbage -d";
      };
    };
  };
}
