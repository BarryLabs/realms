{
  description = ''
    Title: Realms
    Author: BarryLabs

    Install pre-configured servers including my daily drivers
    or pull simple modules for your own configuration.
  '';

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , disko
    , sops-nix
    , impermanence
    , nix-minecraft
    , ...
    }@inputs:
    let
      inherit (self) outputs;
      sys = {
        sMob = "aarch64-linux";
        s32 = "i686-linux";
        s64 = "x86_64-linux";
        siMob = "aarch64-darwin";
        sMac = "x86_64-darwin";
      };
      # archs = [
      #   "aarch64-linux"
      #   "i686-linux"
      #   "x86_64-linux"
      #   "aarch64-darwin"
      #   "x86_64-darwin"
      # ];
      # forAllSystems = nixpkgs.lib.genAttrs archs;
    in
    {
      overlays = import ./modules/overlays { inherit inputs; };
      nixosConfigurations = {
        abyss = nixpkgs.lib.nixosSystem {
          system = sys.s64;
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            ./machines/abyss
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.mamotdask = import ./machines/abyss/home.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
        yggdrasil = nixpkgs.lib.nixosSystem {
          system = sys.s64;
          specialArgs = { inherit outputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            ./machines/yggdrasil
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.chandler = import ./machines/yggdrasil/home.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
          ];
        };
        aegir = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/aegir
          ];
        };
        asgard = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/asgard
          ];
        };
        bifrost = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/bifrost
          ];
        };
        heimskringla = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/heimskringla
          ];
        };
        hel = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/hel
          ];
        };
        himinbjorg = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/himinbjorg
          ];
        };
        mini-iso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            sops-nix.nixosModules.sops
            ./machines/mini-iso
          ];
        };
        mini-vm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/mini-vm
          ];
        };
        muspelheim = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/muspelheim
          ];
        };
        tesseract = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/tesseract
          ];
        };
        valaskjalf = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/valaskjalf
          ];
        };
        valhalla = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./machines/valhalla
          ];
        };
      };
    };
}
