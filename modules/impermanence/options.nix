{
  flake.nixosModules.imperm-options = {lib, ...}: {
    options.persistence = {
      enable = lib.mkEnableOption "enable persistence";

      nukeRoot.enable = lib.mkEnableOption "Destroy /root on every boot";

      volumeGroup = lib.mkOption {
        default = "btrfs_vg";
        description = ''
          Btrfs Volume Group Name
        '';
      };

      user = lib.mkOption {
        default = "username";
        description = ''
          Main User
        '';
      };

      directories = lib.mkOption {
        default = [];
        description = ''
          Folders to Persist
        '';
      };

      files = lib.mkOption {
        default = [];
        description = ''
          Files to Persist
        '';
      };

      data.directories = lib.mkOption {
        default = [];
        description = ''
          Folders to Persist
        '';
      };

      data.files = lib.mkOption {
        default = [];
        description = ''
          Files to Persist
        '';
      };

      cache.directories = lib.mkOption {
        default = [];
        description = ''
          Folders to Persist
        '';
      };

      cache.files = lib.mkOption {
        default = [];
        description = ''
          Files to Persist
        '';
      };
    };
  };
}
