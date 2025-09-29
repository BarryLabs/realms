{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.frigate;
in
{
  options.augs.services.frigate.enable = mkEnableOption "Base Frigate Module";
  config = mkIf cfg.enable {
    services = {
      frigate = {
        enable = true;
        hostname = "localhost";
        vaapiDriver = "";
        settings = {
          mqtt.enabled = false;
          ffmpeg.hwaccel_args = "preset-vaapi";
          record = {
            enabled = true;
            retain = {
              days = 30;
              mode = "all";
            };
          };
          cameras = {
            "1" = {
              ffmpeg.inputs = [
                {
                  roles = [ "record" ];
                  input_args = "preset-rtsp-restream";
                  path = "rtsp://127.0.0.1:8554/1";
                }
              ];
            };
            "2" = { };
            "3" = { };
            "4" = { };
          };
        };
      };
      go2rtc = {
        enable = false;
        settings = {
          streams = {
            "1" = [
              "rtsp://10.10.10.10/11"
            ];
          };
          rtsp.listen = ":8554";
          webrtc.listen = ":8555";
        };
      };
    };
  };
}
