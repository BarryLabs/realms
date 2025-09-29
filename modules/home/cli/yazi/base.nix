{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.cli.yazi.base;
in
{
  options.mods.cli.yazi.base.enable = mkEnableOption "Base Yazi Module";
  config = mkIf cfg.enable {
    programs = {
      yazi = {
        enable = true;
        enableZshIntegration = true;
        # enableNushellIntegration = true;
        settings = {
          log = {
            enabled = false;
          };
          mgr = {
            ratio = [
              2
              4
              3
            ];
            show_hidden = true;
            sort_dir_first = true;
            sort_reverse = false;
            sort_sensitive = true;
            show_symlink = true;
          };
        };
        theme = {
          filetype = {
            rules = [
              {
                fg = "#cdd6f4";
                name = "*";
              }
              {
                fg = "#89B4FA";
                name = "*/";
              }
              {
                fg = "#94e2d5";
                mime = "image/*";
              }
              {
                fg = "#f9e2af";
                mime = "{audio,video}/*";
              }
              {
                fg = "#f5c2e7";
                mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
              }
              {
                fg = "#eba0ac";
                mime = "application/{pdf,doc,rtf}";
              }
            ];
          };
        };
      };
    };
  };
}
