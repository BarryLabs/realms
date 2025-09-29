{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.com.tpm2;
in
{
  options.augs.com.tpm2.enable = mkEnableOption "Base TPM2 Module";
  config = mkIf cfg.enable {
    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };
}
