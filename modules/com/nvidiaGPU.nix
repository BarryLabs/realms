{
  flake.nixosModules.nvidiaGPU = {
    config,
    ...
  }: {
    systemd.services.nvidia-power-limit =
      if config.networking.hostName == "yggdrasil"
      then {
        description = "Set Power Limit for 3080 to 150 Watt";
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "/run/current-system/sw/bin/nvidia-smi -pl 150";
        };
      }
      else {};
    services.xserver.videoDrivers = [
      "nvidia"
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        open = false;
        nvidiaSettings = true;
        modesetting = {
          enable = true;
        };
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };
}
