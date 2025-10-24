{ config
, lib
, ...
}:
with lib; let
  module = "chromium";
  cfg = config.mods.browser.${module};
in
{
  options.mods.browser.${module}.enable = mkEnableOption "Base Chromium Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".chromium"
    #   ];
    # };
    programs = {
      ${module} = {
        enable = true;
        commandLineArgs = [
          "--enable-logging=stderr"
          "--ignore-gpu-blocklist"
        ];
        extensions = [
          {
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          }
        ];
      };
    };
  };
}
