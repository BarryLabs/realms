{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.cli.starship.base;
in
{
  options.mods.cli.starship.base.enable = mkEnableOption "Base Starship Module";
  config = mkIf cfg.enable {
    programs = {
      starship = {
        enable = true;
        enableNushellIntegration = true;
        settings = {
          add_newline = false;
          format = lib.concatStrings [
            "$all"
            "$line_break"
            "$character"
          ];
          scan_timeout = 10;
          character = {
            success_symbol = "[➜](bold green) ";
            error_symbol = "[✗](bold red) ";
          };
          buf = {
            symbol = " ";
          };
          hostname = {
            ssh_symbol = " ";
          };
          username = {
            show_always = true;
          };
          directory = {
            style = "bold italic blue";
            read_only = " 󰌾";
            truncate_to_repo = true;
          };
          docker_context = {
            style = "bold blue";
            symbol = " ";
          };
          c = {
            symbol = " ";
          };
          fossil_branch = {
            symbol = " ";
          };
          git_branch = {
            symbol = " ";
          };
          golang = {
            symbol = " ";
          };
          hg_branch = {
            symbol = " ";
          };
          lua = {
            symbol = " ";
          };
          memory_usage = {
            symbol = "󰍛 ";
          };
          meson = {
            symbol = "󰔷 ";
          };
          nim = {
            symbol = "󰆥 ";
          };
          nix_shell = {
            symbol = " ";
          };
          nodejs = {
            symbol = " ";
          };
          ocaml = {
            symbol = " ";
          };
          package = {
            symbol = "󰏗 ";
          };
          python = {
            style = "bold yellow";
            symbol = " ";
          };
          rust = {
            symbol = " ";
          };
          swift = {
            symbol = " ";
          };
          zig = {
            symbol = " ";
          };
        };
      };
    };
  };
}
