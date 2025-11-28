{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  xdg.mimeApps =
    let
      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name;
            value =
              let
                zen-browser = config.programs.zen-browser.package;
              in
              zen-browser.meta.desktopFileName;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };

  programs.zen-browser = {
    enable = true;

    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );

        mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

        mkExtensionEntry =
          {
            id,
            pinned ? false,
          }:
          let
            base = {
              install_url = mkPluginUrl id;
              installation_mode = "force_installed";
            };
          in
          if pinned then base // { default_area = "navbar"; } else base;

        mkExtensionSettings = builtins.mapAttrs (
          _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
        );
      in
      {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = true;
        PasswordManagerEnabled = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SanitizeOnShutdown = {
          FormData = true;
          Cache = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "wappalyzer@crunchlabz.com" = mkExtensionEntry {
            id = "wappalyzer";
            pinned = true;
          };
          "uBlock0@raymondhill.net" = mkExtensionEntry {
            id = "ublock-origin";
            pinned = true;
          };
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github-";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
          "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
          "github-no-more@ihatereality.space" = "github-no-more";
          "github-repository-size@pranavmangal" = "gh-repo-size";
          "firefox-extension@steamdb.info" = "steam-database";
          "@searchengineadremover" = "searchengineadremover";
          "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
          "trackmenot@mrl.nyu.edu" = "trackmenot";
          "{861a3982-bb3b-49c6-bc17-4f50de104da1}" = "custom-user-agent-revived";
          "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = "chameleon-ext";
        };
        Preferences = mkLockedAttrs {
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.warnOnClose" = false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
          "browser.gesture.swipe.left" = "";
          "browser.gesture.swipe.right" = "";
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.topsites.contile.enabled" = false;

          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.randomization.canvas.use_siphash" = true;
          "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
          "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.spoof_english" = 1;

          "privacy.firstparty.isolate" = true;
          "network.cookie.cookieBehavior" = 5;
          "dom.battery.enabled" = false;

          "gfx.webrender.all" = true;
          "network.http.http3.enabled" = true;
          "network.socket.ip_addr_any.disabled" = true;
        };
      };

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.natural-scroll" = true;
        "zen.view.compact" = true;
        "zen.view.compact.hide-tabbar" = false;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.animate-sidebar" = true;
        "zen.welcome-screen.seen" = true;
        "zen.urlbar.behavior" = "float";
        "zen.view.use-single-toolbar" = true;
        "zen.view.sidebar-expanded" = true;
        "zen.tabs.vertical.right-side" = true;

        # Enable password manager
        "signon.rememberSignons" = true;
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "logins-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [
              "firefox-view-button"
              "tabbrowser-tabs"
              "alltabs-button"
            ];
            PersonalToolbar = [
              "personal-bookmarks"
              "managed-bookmarks"
            ];
          };
          currentVersion = 20;
          newElementCount = 7;
        };
        # macOS Touch ID authentication
        "identity.fxaccounts.pairing.enabled" = true;
        "signon.management.page.os-auth.enabled" = true;
        "extensions.formautofill.reauth.enabled" = true;
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };

      pinsForce = true;
      pins = {
        "GitHub" = {
          id = "github-pin";
          url = "https://github.com";
          position = 1;
          isEssential = true;
        };
        "Gmail" = {
          id = "gmail-pin";
          url = "https://mail.google.com";
          position = 2;
          isEssential = true;
        };
        "Calendar" = {
          id = "calendar-pin";
          url = "https://calendar.google.com";
          position = 3;
          isEssential = true;
        };
      };

      search = {
        force = true;
        default = "google";
        engines =
          let
            nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          in
          {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "np" ];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "nop" ];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master";
                    }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "hmop" ];
            };

            "youtube" = {
              urls = [ { template = "https://youtube.com/results?search_query={searchTerms}"; } ];
              definedAliases = [ "yt" ];
            };
            bing.metaData.hidden = "true";
          };
      };
    };
  };
}
