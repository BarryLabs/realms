{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.cli.nushell.base;
in
{
  options.mods.cli.nushell.base.enable = mkEnableOption "Base Nushell Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unixtools.netstat
    ];
    programs = {
      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
      nushell = {
        enable = true;
        shellAliases = {
          l = "ls -a";
          c = "clear";
          h = "history";
          ports = "netstat -tulanp";
          nb = "sudo nixos-rebuild switch --flake";
          nc = "sudo nix-collect-garbage -d";
        };
        extraConfig = ''
          $env.EDITOR = "hx"
          $env.NIX_LOG = "info"
          $env.NIX_PATH = "nixpkgs=channel:nixos-unstable"
          $env.GIT_SSH_COMMAND = "ssh -i ~/.ssh/barrylabs"

          let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
          }

          $env.config = {
           show_banner: false,
           completions: {
           case_sensitive: false
           quick: true
           partial: true
           algorithm: "fuzzy"
           external: {
               enable: true 
               max_results: 100 
               completer: $carapace_completer
             }
           }
          }

          $env.PATH = ($env.PATH |
          split row (char esep) |
          prepend /home/chandler/.apps |
          append /usr/bin/env
          )
        '';
      };
    };
  };
}
