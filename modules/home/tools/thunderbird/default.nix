{ config
, lib
, ...
}:
with lib; let
  module = "thunderbird";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Thunderbird Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".mozilla"
    #     ".thunderbird"
    #   ];
    # };
    programs = {
      thunderbird = {
        enable = true;
        settings = {
          "privacy.donottrackheader.enabled" = true;
          "extensions.autoDisableScopes" = 0;
        };
        profiles = {
          default = {
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
