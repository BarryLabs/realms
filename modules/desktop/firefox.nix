{
  flake.nixosModules.qutebrowser = {pkgs, ...}: {
    environment.systemPackages = [pkgs.firefox];
  };
  flake.homeModules.qutebrowser = {
    programs = {
      firefox = let
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
      in {
        enable = true;
        languagePacks = ["en-US"];
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
            "keepassxc-browser@keepassxc.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
              installation_mode = "force_installed";
            };
          };
          Preferences = {
            "layout.css.prefers-color-scheme.content-override" = lock-zero;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;

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

            "media.peerconnection.enabled" = lock-false;
            "signon.rememberSignons" = lock-false;
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
            "toolkit.telemetry.unified" = lock-false;
            "toolkit.telemetry.archive.enabled" = lock-false;
            "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
            "toolkit.telemetry.hybridContent.enabled" = lock-false;
            "toolkit.telemetry.newProfilePing.enabled" = lock-false;
            "toolkit.telemetry.reportingpolicy.firstRun" = lock-false;
            "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
            "toolkit.telemetry.updatePing.enabled" = lock-false;
            "datareporting.healthreport.uploadEnabled" = lock-false;
            "datareporting.policy.dataSubmissionEnabled" = lock-false;
            "datareporting.sessions.current.clean" = lock-true;
            "dom.security.https_only_mode" = lock-true;
            "dom.security.https_only_mode_ever_enabled" = lock-true;

            "app.shield.optoutstudies.enabled" = lock-false;
            "media.webrtc.pipewire.enabled" = lock-true;
            "browser.menu.showViewImageInfo" = lock-true;
            "browser.cache.disk.enable" = lock-false;
            "browser.sessionstore.interval" = 60000;
            "browser.sessionhistory.max_total_viewers" = 4;
            "browser.sessionstore.privacy_level" = 2;
            "content.notify.interval" = 100000;
            "gfx.canvas.accelerated.cache-size" = 512;
            "gfx.content.skia-font-cache-size" = 20;
            "image.mem.decode_bytes_at_a_time" = 32768;
            "media.cache_readahead_limit" = 7200;
            "media.cache_resume_threshold" = 3600;
            "media.memory_cache_max_size" = 65536;
            "network.http.max-connections" = 1800;
            "network.http.max-persistent-connections-per-server" = 10;
            "network.http.pacing.requests.enabled" = lock-false;
            "network.dnsCacheExpiration" = 3600;
            "network.ssl_tokens_cache_capacity" = 10240;
            "app.normandy.enabled" = lock-false;
            "geo.provider.use_corelocation" = lock-false;
            "geo.provider.use_geoclue" = lock-false;
            "geo.provider.ms-windows-location" = lock-false;
            "permissions.default.geo" = 2;
            "permissions.default.desktop-notification" = 2;
            "privacy.sanitize.sanitizeOnShutdown" = lock-true;
            "privacy.clearOnShutdown_v2.cache" = lock-true;
            "privacy.clearOnShutdown_v2.downloads" = lock-true;
            "privacy.clearOnShutdown_v2.formdata" = lock-true;
            "privacy.clearHistory.cookiesAndStorage" = lock-false;
            "security.ssl.require_safe_negotiation" = lock-true;
            "security.tls.enable_0rtt_data" = lock-false;
            "security.OCSP.require" = lock-true;
            "security.cert_pinning.enforcement_level" = 2;
            "security.mixed_content.block_display_content" = lock-true;
            "network.auth.subresource-http-auth-allow" = 1;
            "network.IDN_show_punycode" = lock-true;
            "browser.xul.error_pages.expert_bad_cert" = lock-true;
          };
        };
      };
    };
  };
}
