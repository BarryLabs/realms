{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.browser.chromium.base;
in
{
  options.mods.browser.chromium.base.enable = mkEnableOption "Base Chromium Module";
  config = mkIf cfg.enable {
    programs = {
      chromium = {
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
