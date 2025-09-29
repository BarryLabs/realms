{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.virt-manager;
in
{
  options.augs.com.virt-manager.enable = mkEnableOption "Base Virt-Manager Module";
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
