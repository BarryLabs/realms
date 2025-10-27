{ config
, lib
, ...
}:
with lib; let
  module = "locale";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Locale Module";
  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = config.var.locale;
      extraLocaleSettings = {
        LC_ADDRESS = config.var.locale;
        LC_IDENTIFICATION = config.var.locale;
        LC_MEASUREMENT = config.var.locale;
        LC_MONETARY = config.var.locale;
        LC_NAME = config.var.locale;
        LC_NUMERIC = config.var.locale;
        LC_PAPER = config.var.locale;
        LC_TELEPHONE = config.var.locale;
        LC_TIME = config.var.locale;
      };
    };
  };
}
