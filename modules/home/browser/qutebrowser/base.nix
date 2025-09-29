{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.browser.qutebrowser.base;
in
{
  options.mods.browser.qutebrowser.base.enable = mkEnableOption "Base Qutebrowser Module";
  config = mkIf cfg.enable {
    programs = {
      qutebrowser = {
        enable = true;
        aliases = { };
        quickmarks = {
          gog = "https://www.gog.com/en/";
          anime = "https://hianime.tv/";
          world = "https://lemmy.world/";
          homepage = "http://192.168.70.5:8082/";
          guix-cookbook = "https://guix.gnu.org/cookbook/en/guix-cookbook.html";
          nix-resources = "https://nixos.wiki/wiki/Resources#Cookbooks";
          rust-cookbook = "https://rust-lang-nursery.github.io/rust-cookbook/";
          zig-cookbook = "https://zig.guide/";
        };
        greasemonkey = [
          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/reddit_adblock.js";
            sha256 = "sha256-KmCXL4GrZtwPLRyAvAxADpyjbdY5UFnS/XKZFKtg7tk=";
          })
          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_adblock.js";
            sha256 = "sha256-EuGTJ9Am5C6g3MeTsjBQqyNFBiGAIWh+f6cUtEHu3iI=";
          })
          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_sponsorblock.js";
            sha256 = "sha256-e3QgDPa3AOpPyzwvVjPQyEsSUC9goisjBUDMxLwg8ZE=";
          })
        ];
        searchEngines = {
          a = "https://hianimez.to/search?keyword={}";
          g = "https://www.google.com/search?hl=en&amp;q={}";
          r = "https://www.reddit.com/search/?q={}&cId=ade09f9e-6ac2-419d-b0a6-29253a1eaefa&iId=3f1d2b4a-b08e-4081-a166-ddbbf1f5da19";
          w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
          yt = "https://www.youtube.com/results?search_query={}";
          gh = "https://github.com/search?q={}&type=repositories";
          nix = "https://mynixos.com/search?q={}";
          game = "https://www.cheapshark.com/search#q:{}";
        };
        settings = {
          colors = {
            webpage = {
              darkmode = {
                enabled = true;
              };
            };
          };
        };
      };
    };
  };
}
