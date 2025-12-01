{pkgs}:
pkgs.writeShellScriptBin "screenshot" ''
  grim -g "$(slurp)" - | swappy -f -
''
