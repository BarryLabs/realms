{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.k3s.agent;
in
{
  options.augs.services.k3s.agent.enable = mkEnableOption "Base k3s Agent Module";
  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "agent";
      token = "";
      serverAddr = "https://<orchestrator>:6443";
    };
  };
}
