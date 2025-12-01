{ config
, lib
, ...
}:
with lib;
let
  module = "k3s-agent";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "k3s Agent Module";
  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "agent";
      token = "";
      serverAddr = "https://<orchestrator>:6443";
    };
  };
}
