{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.services.email;
in
{
  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-24.11/nixos-mailserver-nixos-24.11.tar.gz";
      sha256 = "0lgrqdgb4z45ng875pa47m2vm7p3hhxn4n80x9z4qwvcdrrxrgch";
    })
  ];
  options.augs.services.email.enable = mkEnableOption "Base Email Module";
  config = mkIf cfg.enable {
    mailserver = {
      enable = true;
      fqdn = "mail.mamot.cc";
      domains = [ "mamot.cc" ];
      # A list of all login accounts. To create the password hashes, use
      # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
      loginAccounts = {
        "chandler@mamot.cc" = {
          aliases = [ "postmaster@example.com" ];
          hashedPasswordFile = "/a/file/containing/a/hashed/password";
        };
      };
      certificateScheme = "acme-nginx";
    };
    security.acme.acceptTerms = true;
    security.acme.defaults.email = "security@mamot.cc";
  };
}
