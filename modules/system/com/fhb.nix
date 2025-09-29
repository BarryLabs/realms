{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.fhb;
in
{
  options.augs.com.fhb.enable = mkEnableOption "File Hierarchy Builder Module";
  config = mkIf cfg.enable {
    system = {
      activationScripts = {
        "fhsBuilder" = {
          text = lib.mkDefault ''
            install -d -m 755 /mnt/USB -o ${config.var.user} -g users
            install -d -m 755 /home/${config.var.user}/Documents -o ${config.var.user} -g users
            install -d -m 755 /home/${config.var.user}/Downloads -o ${config.var.user} -g users
            install -d -m 755 /home/${config.var.user}/Music -o ${config.var.user} -g users
            install -d -m 755 /home/${config.var.user}/Pictures -o ${config.var.user} -g users
            install -d -m 755 /home/${config.var.user}/Projects -o ${config.var.user} -g users
            install -d -m 755 /home/${config.var.user}/Videos -o ${config.var.user} -g users
          '';
        };
      };
    };
  };
}
