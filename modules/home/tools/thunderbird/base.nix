{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.tools.thunderbird.base;
in
{
  options.mods.tools.thunderbird.base.enable = mkEnableOption "Chandler's Thunderbird Module";
  config = mkIf cfg.enable {
    programs = {
      thunderbird = {
        enable = true;
        settings = {
          "privacy.donottrackheader.enabled" = true;
          "extensions.autoDisableScopes" = 0;
        };
        profiles = {
          chandler = {
            isDefault = true;
            withExternalGnupg = true;
            settings = {
              "mail.spellcheck.inline" = false;
              "mailnews.database.global.views.global.columns" = {
                selectCol = {
                  visible = false;
                  ordinal = 1;
                };
                threadCol = {
                  visible = true;
                  ordinal = 2;
                };
              };
            };
          };
        };
      };
    };
  };
}
