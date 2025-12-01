{ pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
    ../../modules/profile/system
  ];

  augs = {
    profile = {
      monitoring.enable = true;
      server.enable = true;
    };
    com = {
      intelGPU.enable = true;
      nh.enable = true;
    };
    oci = {
      torrent.enable = false;
      transcode.enable = false;
    };
  };

  system.activationScripts = {
    "media-FolderHandler" = {
      text = ''
        install -d -m 755 /srv/Media -o root -g root
      '';
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
