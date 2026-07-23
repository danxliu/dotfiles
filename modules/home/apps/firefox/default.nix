{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };

    profiles.default = {
      isDefault = true;
      search.force = true;
      settings = {
        "browser.startup.homepage" = "https://danxliu.com/startpage";
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_from_crash" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.ctrlTab.previews" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "browser.urlbar.suggest.recentsearches" = false;
        "dom.battery.enabled" = false;
        "browser.uiCustomization.state" =
          ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action","firefox_tampermonkey_net-browser-action","firefox-extension_steamdb_info-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","chrome-gnome-shell_gnome_org-browser-action","frankerfacez_frankerfacez_com-browser-action","_194d0dc6-7ada-41c6-88b8-95d7636fe43c_-browser-action","_988dd4f5-e8d5-49bf-a766-ff75b0e19fe2_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"nav-bar":["sidebar-button","back-button","forward-button","customizableui-special-spring4","urlbar-container","customizableui-special-spring5","vertical-spacer","unified-extensions-button","downloads-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["developer-button","screenshot-button","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action","ublock0_raymondhill_net-browser-action","firefox_tampermonkey_net-browser-action","firefox-extension_steamdb_info-browser-action","sponsorblocker_ajay_app-browser-action","78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","chrome-gnome-shell_gnome_org-browser-action","frankerfacez_frankerfacez_com-browser-action","_testpilot-containers-browser-action","_194d0dc6-7ada-41c6-88b8-95d7636fe43c_-browser-action","_988dd4f5-e8d5-49bf-a766-ff75b0e19fe2_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","PersonalToolbar","toolbar-menubar","unified-extensions-area"],"currentVersion":23,"newElementCount":6}'';
      };

      search.engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        nixos-wiki = {
          name = "NixOS Wiki";
          urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
          icon = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@nw" ];
        };

        home-manager-options = {
          name = "HomeManager Options";
          urls = [
            { template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master"; }
          ];
          icon = "https://wiki.nixos.org/favicon.ico";
          definedAliases = [ "@hm" ];
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        clearurls
        csgo-trader-steam-trading
        csgofloat
        dont-track-me-google1
        multi-account-containers
        frankerfacez
        gnome-shell-integration
        localcdn
        proton-pass
        return-youtube-dislikes
        sponsorblock
        steam-database
        tampermonkey
        ublock-origin
        youtube-shorts-block
      ];
    };
  };
}
