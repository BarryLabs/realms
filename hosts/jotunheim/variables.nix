{
  lib,
  config,
  ...
}: {
  options.jotunheim = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.jotunheim = {
    host = "jotunheim";
    user = "chandler";
    desc = "${config.jotunheim.host}'s Android.";
    home = "/data/data/com.termux.nix/files/home/${config.jotunheim.user}";
    iniPass = "password";
    locale = "en_US.UTF-8";
    timezone = "America/New_York";
    ageFile = "/data/data/com.termux.nix/files/home/.config/sops/age/keys.txt";
    state = "24.05";
  };
}
