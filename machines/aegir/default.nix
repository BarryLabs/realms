{ pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    com = {
      bash.enable = true;
      bootGRUB.enable = true;
      docs.enable = true;
      environment.enable = true;
      kernel.enable = true;
      locale.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      openssh.enable = true;
      qemuguest.enable = true;
      sops.enable = false;
      state.enable = true;
      timezone.enable = true;
      users.enable = true;
    };
    oci = {
      torrent.enable = false;
      transcode.enable = false;
    };
    services = {
      arr.enable = false;
      node-exporter.enable = false;
      promtail.enable = false;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        8080
        8265
      ];
    };
  };

  fileSystems."/srv/Media" = {
    fsType = "ext4";
    device = "/dev/disk/by-uuid/0b934573-b026-43c2-95ec-24340cf546e1";
  };

  system = {
    activationScripts = {
      "media-FolderHandler" = {
        text = ''
          install -d -m 755 /srv/Media -o root -g root
        '';
      };
    };
  };

  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "aspnetcore-runtime-6.0.36"
      ];
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-sdk
        intel-vaapi-driver
        intel-media-driver
        intel-compute-runtime
        vaapiVdpau
        vpl-gpu-rt
      ];
    };
  };

  # sops = {
  #   secrets = {
  #     borgJob = {
  #       mode = "0400";
  #     };
  #     bbAegir = {
  #       mode = "0400";
  #     };
  #     localAegirEncKey = {
  #       mode = "0400";
  #     };
  #     remoteAegirEncKey = {
  #       mode = "0400";
  #     };
  #   };
  # };
}
