{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.nixpkgs;
in
{
  options.augs.com.nixpkgs.enable = mkEnableOption "Nixpkgs Module for Realms";
  config = mkIf cfg.enable {
    nixpkgs = {
      hostPlatform = lib.mkDefault "x86_64-linux";
      config = {
        allowUnfree = lib.mkDefault false;
        allowUnfreePredicate =
          if config.networking.hostName == "abyss"
          then
            pkg:
            builtins.elem (lib.getName pkg) [
              "nvidia-x11"
              "nvidia-settings"
              "steam"
              "steam-unwrapped"
              "cuda_cudart"
              "libcublas"
              "cuda_cccl"
              "cuda_nvcc"
              "xow_dongle-firmware"
              "obsidian"
            ]
          else if config.networking.hostName == "yggdrasil"
          then
            pkg:
            builtins.elem (lib.getName pkg) [
              "nvidia-x11"
              "nvidia-settings"
              "steam"
              "steam-unwrapped"
              "cuda_cudart"
              "libcublas"
              "cuda_cccl"
              "cuda_nvcc"
              "xow_dongle-firmware"
              "obsidian"
            ]
          else [ ];
      };
    };
  };
}
