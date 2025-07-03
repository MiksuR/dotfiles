{ pkgs, ... }:

let
  lock-false = { Value = false; Status = "locked"; };
  lock-true = { Value = true; Status = "locked"; };
in
{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisplayBookmarksToolbar = "always";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Homepage = {
        StartPage = "homepage-locked";
      };
      HttpsOnlyMode = "enabled";
      OfferToSaveLogins = false;
      PromptForDownloadLocation = true;
      ShowHomeButton = true;
      Preferences = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;
        "privacy.globalprivacycontrol.enabled" = lock-true;
        "privacy.donottrackheader.enabled" = lock-true;
        "app.shield.optoutstudies.enabled" = lock-false;
        "middlemouse.paste" = lock-false;
      };
    };

    profiles.default = {
      search.default = "ddg";
      search.force = true;
      userChrome = (builtins.readFile ./userChrome.css);

      settings = {
        "browser.download.useDownloadDir" = "false";
        "browser.startup.homepage" = "https://www.duckduckgo.com/";
      };
    };
  };
}
