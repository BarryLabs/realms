{ pkgs, ... }:
{
  imports = [
    ./file.nix
  ];
  home = {
    packages = [
      (import ./program.nix { inherit pkgs; })
    ];
  };
}
