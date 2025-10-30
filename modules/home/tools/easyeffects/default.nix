{ config
, lib
, ...
}:
with lib; let
  module = "easyeffects";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Easyeffects Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/easyeffects"
    #   ];
    # };
    services = {
      easyeffects = {
        enable = true;
        # extraPresets = {
        #   jbl770 = {
        #     output = {
        #       blocklist = [ ];
        #       "plugins_order" = [
        #         "gate#0"
        #         "compressor#0"
        #         "equalizer#0"
        #         "limiter#0"
        #       ];
        #       "gate#0" = {
        #         "attack" = 2000.0;
        #         bypass = false;
        #         "curve-threshold" = -40.0;
        #         "curve-zone" = -40.0;
        #         dry = -100.0;
        #         "hpf-frequency" = 10.0;
        #         "hpf-mode" = "off";
        #         "hysteresis" = false;
        #         "hysteresis-zone" = -6.0;
        #         "hysteresis-threshold" = -12.0;
        #         "input-gain" = 0.0;
        #         "lpf-mode" = "off";
        #         "lpf-frequency" = 20000.0;
        #         "makeup" = 0.0;
        #         "output-gain" = 0.0;
        #         "reduction" = -30.0;
        #         "release" = 2000.0;
        #         "sidechain" = {
        #           "input" = "Internal";
        #           "lookahead" = 0.0;
        #           "mode" = "Peak";
        #           "preamp" = -4.15;
        #           "reactivity" = 10.0;
        #           "source" = "Middle";
        #           "stereo-split-source" = "Left/Right";
        #         };
        #         "stereo-split" = false;
        #         wet = 0.0;
        #       };
        #       "compressor#0" = {
        #         "attack" = 50.0;
        #         "boost-amount" = 3.0;
        #         "boost-threshold" = -20.0;
        #         bypass = false;
        #         dry = -100.0;
        #         "hpf-mode" = "off";
        #         "hpf-frequency" = 10.0;
        #         "input-gain" = 0.0;
        #         "knee" = -24.0;
        #         "lpf-mode" = "off";
        #         "lpf-frequency" = 20000.0;
        #         "makeup" = 3.0;
        #         "mode" = "Upward";
        #         "output-gain" = 0.0;
        #         "ratio" = 4.0;
        #         "release" = 150.0;
        #         "release-threshold" = -100.0;
        #         "sidechain" = {
        #           "lookahead" = 0.0;
        #           "mode" = "RMS";
        #           "preamp" = -4.15;
        #           "reactivity" = 10.0;
        #           "source" = "Middle";
        #           "stereo-split-source" = "Left/Right";
        #           "type" = "Feed-forward";
        #         };
        #         "stereo-split" = false;
        #         "threshold" = -20.0;
        #         wet = 0.0;
        #       };
        #       "equalizer#0" = {
        #         "balance" = 0.0;
        #         bypass = false;
        #         "input-gain" = 0.0;
        #         "left" = {
        #           "band0" = {
        #             "gain" = -2.8;
        #             "q" = 0.70;
        #             "frequency" = 105.0;
        #           };
        #           "band1" = {
        #             "gain" = -6.1;
        #             "q" = 1.15;
        #             "frequency" = 88.7;
        #           };
        #           "band2" = {
        #             "gain" = -1.2;
        #             "q" = 2.00;
        #             "frequency" = 332.3;
        #           };
        #           "band3" = {
        #             "gain" = 3.8;
        #             "q" = 1.22;
        #             "frequency" = 509.5;
        #           };
        #           "band4" = {
        #             "gain" = 2.5;
        #             "q" = 2.41;
        #             "frequency" = 771.4;
        #           };
        #           "band5" = {
        #             "gain" = -2.0;
        #             "q" = 1.13;
        #             "frequency" = 1250.3;
        #           };
        #           "band6" = {
        #             "gain" = -1.1;
        #             "q" = 2.15;
        #             "frequency" = 2521.9;
        #           };
        #           "band7" = {
        #             "gain" = 4.3;
        #             "q" = 4.00;
        #             "frequency" = 4986.5;
        #           };
        #           "band8" = {
        #             "gain" = 2.1;
        #             "q" = 2.70;
        #             "frequency" = 9362.1;
        #           };
        #           "band9" = {
        #             "gain" = -3.9;
        #             "q" = 0.70;
        #             "frequency" = 10000.0;
        #           };
        #         };
        #         "mode" = "IIR";
        #         "num-bands" = 10;
        #         "output-gain" = 0.0;
        #         "right" = {
        #           "band0" = {
        #             "gain" = -2.8;
        #             "q" = 0.70;
        #             "frequency" = 105.0;
        #           };
        #           "band1" = {
        #             "gain" = -6.1;
        #             "q" = 1.15;
        #             "frequency" = 88.7;
        #           };
        #           "band2" = {
        #             "gain" = -1.2;
        #             "q" = 2.00;
        #             "frequency" = 332.3;
        #           };
        #           "band3" = {
        #             "gain" = 3.8;
        #             "q" = 1.22;
        #             "frequency" = 509.5;
        #           };
        #           "band4" = {
        #             "gain" = 2.5;
        #             "q" = 2.41;
        #             "frequency" = 771.4;
        #           };
        #           "band5" = {
        #             "gain" = -2.0;
        #             "q" = 1.13;
        #             "frequency" = 1250.3;
        #           };
        #           "band6" = {
        #             "gain" = -1.1;
        #             "q" = 2.15;
        #             "frequency" = 2521.9;
        #           };
        #           "band7" = {
        #             "gain" = 4.3;
        #             "q" = 4.00;
        #             "frequency" = 4986.5;
        #           };
        #           "band8" = {
        #             "gain" = 2.1;
        #             "q" = 2.70;
        #             "frequency" = 9362.1;
        #           };
        #           "band9" = {
        #             "gain" = -3.9;
        #             "q" = 0.70;
        #             "frequency" = 10000.0;
        #           };
        #         };
        #         "split-channels" = false;
        #       };
        #       "limiter#0" = {
        #         "alr" = false;
        #         "alr-knee" = 0.0;
        #         "alr-attack" = 5.0;
        #         "alr-release" = 50.0;
        #         "attack" = 5.0;
        #         bypass = false;
        #         "dithering" = "None";
        #         "external-sidechain" = false;
        #         "gain-boost" = false;
        #         "input-gain" = 0.0;
        #         "lookahead" = 5.0;
        #         "mode" = "Herm Thin";
        #         "output-gain" = 0.0;
        #         "oversampling" = "Half x4(3L)";
        #         "release" = 10.0;
        #         "sidechain-preamp" = 0.0;
        #         "stereo-link" = 100.0;
        #         "threshold" = -1.0;
        #       };
        #     };
        #   };
        #   bNoise = {
        #     input = {
        #       blocklist = [ ];
        #       "plugins_order" = [
        #         "rnnoise#0"
        #       ];
        #       "rnnoise#0" = {
        #         bypass = false;
        #         "enable-vad" = false;
        #         "input-gain" = 0.0;
        #         "model-path" = "";
        #         "output-gain" = 0.0;
        #         release = 20.0;
        #         "vad-thres" = 50.0;
        #         wet = 0.0;
        #       };
        #     };
        #   };
        # };
      };
    };
  };
}
