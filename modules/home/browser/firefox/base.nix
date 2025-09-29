{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.browser.firefox.base;
in
{
  options.mods.browser.firefox.base.enable = mkEnableOption "Base Firefox Module";
  config = mkIf cfg.enable {
    programs = {
      firefox =
        let
          lock-zero = {
            Value = 0;
            Status = "locked";
          };
          lock-false = {
            Value = false;
            Status = "locked";
          };
          lock-true = {
            Value = true;
            Status = "locked";
          };
        in
        {
          enable = true;
          languagePacks = [ "en-US" ];
          policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
            DisablePocket = true;
            DisableFirefoxAccounts = true;
            DisableAccounts = true;
            DisableFirefoxScreenshots = true;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            DisplayBookmarksToolbar = "never";
            DisplayMenuBar = "default-off";
            SearchBar = "unified";
            ExtensionSettings = {
              "*".installation_mode = "blocked";
              "uBlock0@raymondhill.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
              };
              "jid1-MnnxcxisBPnSXQ@jetpack" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
                installation_mode = "force_installed";
              };
              "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
                installation_mode = "force_installed";
              };
              "addon@darkreader.org" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                installation_mode = "force_installed";
              };
              "firefox@tampermonkey.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
                installation_mode = "force_installed";
              };
              "sponsorBlocker@ajay.app" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                installation_mode = "force_installed";
              };
            };
            Preferences = {
              "signon.rememberSignons" = lock-false;
              "media.peerconnection.enabled" = lock-false;
              "browser.contentblocking.category" = {
                Value = "strict";
                Status = "locked";
              };
              "extensions.pocket.enabled" = lock-false;
              "extensions.screenshots.disabled" = lock-true;
              "browser.topsites.contile.enabled" = lock-false;
              "browser.formfill.enable" = lock-false;
              "browser.search.suggest.enabled" = lock-false;
              "browser.search.suggest.enabled.private" = lock-false;
              "browser.urlbar.suggest.searches" = lock-false;
              "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
              "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
              "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
              "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
              "browser.newtabpage.activity-stream.showSponsored" = lock-false;
              "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
              "layout.css.prefers-color-scheme.content-override" = lock-zero;
            };
          };
        };
    };
  };
}
