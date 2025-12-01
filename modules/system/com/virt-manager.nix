{ config
, lib
, ...
}:
with lib; let
  module = "virt-manager";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Virt-Manager Module";
  config = mkIf cfg.enable {
    users.extraGroups.libvirtd.members = [ config.var.user ];
    programs = {
      virt-manager = {
        enable = true;
      };
    };
    virtualisation = {
      libvirtd = {
        enable = true;
      };
    };
  };
}
