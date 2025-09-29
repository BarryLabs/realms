{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.mods.tools.pidgin.base;
in
{
  options.mods.tools.pidgin.base.enable = mkEnableOption "Base Pidgin Module";
  config = mkIf cfg.enable {
    programs = {
      pidgin = {
        enable = true;
        plugins = with pkgs; [
          pidgin-xmpp-receipts
          pidgin-opensteamworks
        ];
      };
    };
  };
}
