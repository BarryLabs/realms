{ config
, lib
, ...
}:
with lib;
let
  module = "server";
  cfg = config.augs.profile.${module};
in
{
  imports = [
    ../../../system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Server Profile";
  config = mkIf cfg.enable {
    augs = {
      com = {
        bash.enable = true;
        bootGRUB.enable = true;
        environment.enable = true;
        fstrim.enable = true;
        locale.enable = true;
        network.enable = true;
        nix.enable = true;
        nixpkgs.enable = true;
        openssh.enable = true;
        qemuguest.enable = true;
        state.enable = true;
        sudo-rs.enable = true;
        timezone.enable = true;
        users.enable = true;
      };
    };
  };
}
