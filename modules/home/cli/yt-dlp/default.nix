{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "yt-dlp";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "YT-DLP Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yt-dlp
      #(pkgs.writeShellScriptBin "yt-dlm" ''
      #  mkdir "$1"
      #  cd "$1"
      #  yt-dlp --extract-audio --audio-format 'flac>flac/opus' --audio-quality 0 --output '%(title)s.%(ext)s' "$2"
      #  cd ..    
      #'')
    ];
  };
}
