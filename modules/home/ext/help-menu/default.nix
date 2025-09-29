{ pkgs, ... }:
{
  home = {
    packages = [
      (import ./program.nix { inherit pkgs; })
    ];
  };
}
