{lib, ...}: {
  flake.nixosModules.nix = {
    nix = {
      settings = {
        auto-optimise-store = true;
        allowed-users = [
          "root"
          "@wheel"
        ];
        # cores = 8;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://cache.nixos-cuda.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
      };
    };
    nixpkgs = {
      hostPlatform = lib.mkDefault "x86_64-linux";
      config = {
        # allowUnfree = true;
        allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "nvidia-x11"
            "nvidia-settings"
            "nvidia-kernel-modules"
            "steam"
            "steam-unwrapped"
            "cuda_cudart"
            "libcublas"
            "cuda_cccl"
            "cuda_nvcc"
            "obsidian"
          ];
      };
    };
  };
}
