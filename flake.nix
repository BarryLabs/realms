{
  description = ''
    Title: Realms
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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , disko
    , sops-nix
    , impermanence
    , stylix
    , nix-on-droid
    , nix-minecraft
    , ...
    }@inputs:
    let
      specialArgs = {
        inherit inputs;
      };
    in
    {
      nixosConfigurations = {
        abyss = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
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
                users.mamotdask = import ./machines/abyss/home.nix;
              };
            }
          ];
        };
        yggdrasil = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            ./machines/yggdrasil
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.chandler = import ./machines/yggdrasil/home.nix;
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
            impermanence.nixosModules.impermanence
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
