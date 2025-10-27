{ config
, lib
, ...
}:
with lib; let
  module = "nixpkgs";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Nixpkgs Module for Realms";
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
