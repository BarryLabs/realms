{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.qdrant;
in
{
  options.augs.services.qdrant.enable = mkEnableOption "Base Qdrant Module";
  config = mkIf cfg.enable {
    services = {
      qdrant = {
        enable = true;
        settings = {
          telemetry_disabled = true;
          hsnw_index = {
            on_disk = true;
          };
          storage = {
            storage_path = "/var/lib/qdrant/storage";
            snapshots_path = "/var/lib/qdrant/snapshots";
          };
          services = {
            host = "127.0.0.1";
            http_port = 6333;
            grpc_port = 6334;
          };
        };
      };
    };
  };
}
