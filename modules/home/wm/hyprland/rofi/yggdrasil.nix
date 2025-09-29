{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.rofi.yggdrasil;
in
{
  options.mods.wm.wayland.rofi.yggdrasil.enable = mkEnableOption "enable rofi for yggdrasil";
  config = mkIf cfg.enable {
    programs = {
      rofi = {
        enable = true;
        extraConfig = {
          modi = "drun,filebrowser,run";
          show-icons = true;
          icon-theme = "Papirus";
          location = 0;
          font = "Source Code Pro 12";
          drun-display-format = "{icon} {name}";
          display-drun = " Apps";
          display-run = " Run";
          display-filebrowser = " File";
        };
        theme =
          let
            inherit (config.lib.formats.rasi) mkLiteral;
          in
          {
            "*" = {
              bg = mkLiteral "#262c5e";
              bg-alt = mkLiteral "#acb0be";
              foreground = mkLiteral "#6c7086";
              selected = mkLiteral "#40a02b";
              active = mkLiteral "#04a5e5";
              text-selected = mkLiteral "#4c4f69";
              text-color = mkLiteral "#ffffff";
              border-color = mkLiteral "#179299";
              urgent = mkLiteral "#e64553";
            };
            "window" = {
              width = mkLiteral "50%";
              transparency = "real";
              orientation = mkLiteral "vertical";
              cursor = mkLiteral "default";
              spacing = mkLiteral "0px";
              border = mkLiteral "2px";
              border-color = "@border-color";
              border-radius = mkLiteral "20px";
              background-color = mkLiteral "@bg";
            };
            "mainbox" = {
              padding = mkLiteral "15px";
              enabled = true;
              orientation = mkLiteral "vertical";
              children = map mkLiteral [
                "inputbar"
                "listbox"
              ];
              background-color = mkLiteral "transparent";
            };
            "inputbar" = {
              enabled = true;
              padding = mkLiteral "10px 10px 10px 10px";
              margin = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              border-radius = "25px";
              orientation = mkLiteral "horizontal";
              children = map mkLiteral [
                "entry"
                "dummy"
                "mode-switcher"
              ];
            };
            "entry" = {
              enabled = true;
              expand = false;
              width = mkLiteral "20%";
              padding = mkLiteral "10px";
              border-radius = mkLiteral "12px";
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@text-selected";
              cursor = mkLiteral "text";
              placeholder = " Search ";
              placeholder-color = mkLiteral "inherit";
            };
            "listbox" = {
              spacing = mkLiteral "10px";
              padding = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              orientation = mkLiteral "vertical";
              children = map mkLiteral [
                "message"
                "listview"
              ];
            };
            "listview" = {
              enabled = true;
              columns = 2;
              lines = 6;
              cycle = true;
              dynamic = true;
              scrollbar = false;
              layout = mkLiteral "vertical";
              reverse = false;
              fixed-height = false;
              fixed-columns = true;
              spacing = mkLiteral "10px";
              background-color = mkLiteral "transparent";
              border = mkLiteral "0px";
            };
            "dummy" = {
              expand = true;
              background-color = mkLiteral "transparent";
            };
            "mode-switcher" = {
              enabled = true;
              spacing = mkLiteral "10px";
              background-color = mkLiteral "transparent";
            };
            "button" = {
              width = mkLiteral "5%";
              padding = mkLiteral "12px";
              border-radius = mkLiteral "12px";
              background-color = mkLiteral "@text-selected";
              text-color = mkLiteral "@text-color";
              cursor = mkLiteral "pointer";
            };
            "button selected" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@text-selected";
            };
            "scrollbar" = {
              width = mkLiteral "4px";
              border = 0;
              handle-color = mkLiteral "@border-color";
              handle-width = mkLiteral "8px";
              padding = 0;
            };
            "element" = {
              enabled = true;
              spacing = mkLiteral "10px";
              padding = mkLiteral "10px";
              border-radius = mkLiteral "12px";
              background-color = mkLiteral "transparent";
              cursor = mkLiteral "pointer";
            };
            "element normal.normal" = {
              background-color = mkLiteral "inherit";
              text-color = mkLiteral "inherit";
            };
            "element normal.urgent" = {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@foreground";
            };
            "element normal.active" = {
              background-color = mkLiteral "@active";
              text-color = mkLiteral "@foreground";
            };
            "element selected.normal" = {
              background-color = mkLiteral "@selected";
              text-color = mkLiteral "@text-selected";
            };
            "element selected.urgent" = {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-selected";
            };
            "element selected.active" = {
              background-color = mkLiteral "@urgent";
              text-color = mkLiteral "@text-selected";
            };
            "element alternate.normal" = {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
            };
            "element alternate.urgent" = {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
            };
            "element alternate.active" = {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
            };
            "element-icon" = {
              background-color = mkLiteral "transparent";
              text-color = mkLiteral "inherit";
              size = mkLiteral "28px";
              cursor = mkLiteral "inherit";
            };
            "element-text" = {
              background-color = mkLiteral "transparent";
              font = "Source Code Pro 12";
              text-color = mkLiteral "inherit";
              cursor = mkLiteral "inherit";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.0";
            };
            "message" = {
              background-color = mkLiteral "transparent";
              border = mkLiteral "0px";
            };
            "textbox" = {
              padding = mkLiteral "12px";
              border-radius = mkLiteral "10px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "@bg";
              vertical-align = mkLiteral "0.5";
              horizontal-align = mkLiteral "0.0";
            };
            "error-message" = {
              padding = mkLiteral "12px";
              border-radius = mkLiteral "20px";
              background-color = mkLiteral "@bg-alt";
              text-color = mkLiteral "@bg";
            };
          };
      };
    };
  };
}
