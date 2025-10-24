{ config
, lib
, ...
}:
with lib;
let
  module = "firefox";
  cfg = config.mods.browser.${module};
in
{
  options.mods.browser.${module}.enable = mkEnableOption "Base Firefox Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".mozilla"
    #   ];
    # };
    programs = {
      ${module} =
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
          # profiles.default = {
          #   isDefault = true;
          #   extensions = with config.nur.repos.rycee.firefox-addons; [
          #     keepassxc-browser
          #   ];
          # };
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
            OverrideFirstRunPage = "http://192.168.70.5:8082/";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            DisplayBookmarksToolbar = "never";
            DisplayMenuBar = "default-off";
            SearchBar = "unified";
            ExtensionSettings = {
              "*".installation_mode = "blocked";
              # "" = {
              #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
              #   installation_mode = "force_installed";
              # };
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
              "browser.aboutConfig.showWarning" = lock-false;
              "browser.aboutwelcome.enabled" = lock-false;
              "browser.bookmarks.addedImportButton" = lock-false;
              "browser.contentblocking.category" = {
                Value = "strict";
                Status = "locked";
              };
              "browser.in-content.dark-mode" = lock-true;

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
              "browser.newtabpage.activity-stream.showSearch" = lock-false;
              "browser.newtabpage.activity-stream.showSponsored" = lock-false;
              "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
              "browser.warnOnQuit" = lock-false;
              "browser.warnOnQuitShortcut" = lock-false;

              "extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
              "extensions.pocket.enabled" = lock-false;
              "extensions.screenshots.disabled" = lock-true;
              "extensions.formautofill.creditCards.enabled" = lock-false;

              "layout.css.prefers-color-scheme.content-override" = lock-zero;

              "media.peerconnection.enabled" = lock-false;
              "signon.rememberSignons" = lock-false;
              "app.shield.optoutstudies.enabled" = lock-false;
              "privacy.trackingprotection.emailtracking.enabled" = lock-true;
              "privacy.trackingprotection.enabled" = lock-true;
              "privacy.trackingprotection.socialtracking.enabled" = lock-true;
              "privacy.resistFingerprinting.randomization.enabled" = lock-true;
              "devtools.onboarding.telemetry.logged" = lock-false;
              "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
              "browser.newtabpage.activity-stream.telemetry" = lock-false;
              "browser.ping-centre.telemetry" = lock-false;
              "toolkit.telemetry.bhrPing.enabled" = lock-false;
              "toolkit.telemetry.enabled" = lock-false;
              "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
              "toolkit.telemetry.hybridContent.enabled" = lock-false;
              "toolkit.telemetry.newProfilePing.enabled" = lock-false;
              "toolkit.telemetry.reportingpolicy.firstRun" = lock-false;
              "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
              "toolkit.telemetry.unified" = lock-false;
              "toolkit.telemetry.updatePing.enabled" = lock-false;
              "toolkit.telemetry.archive.enabled" = lock-false;
              "datareporting.healthreport.uploadEnabled" = lock-false;
              "datareporting.policy.dataSubmissionEnabled" = lock-false;
              "datareporting.sessions.current.clean" = lock-true;
              "dom.security.https_only_mode" = lock-true;
              "dom.security.https_only_mode_ever_enabled" = lock-true;
            };
          };
        };
    };
  };
}
