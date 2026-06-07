{
  pkgs,
  lib,
  ...
}:
with pkgs; let
  patchDesktop = pkg: appName: from: to:
    lib.hiPrio (
      pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
        ${coreutils}/bin/mkdir -p $out/share/applications
        ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      ''
    );
  GPUOffloadApp = pkg: desktopName:
    lib.mkIf config.hardware.nvidia.prime.offload.enable
    (patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ");
in {
  flake.nixosModules.nvidiaGPU-Offload = {
    environment.systemPackages = with pkgs; [
      (GPUOffloadApp steam "steam")
    ];
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = true;
        # nvidiaSettings = true;
        # modesetting.enable = true;
        # powerManagement = {
        #   enable = false;
        #   finegrained = false;
        # };
        prime = {
          intelBusId = "PCI:0@0:2:0";
          nvidiaBusId = "PCI:2@0:0:0";
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };
  };
}
