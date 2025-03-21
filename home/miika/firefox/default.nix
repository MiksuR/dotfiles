{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      search.default = "DuckDuckGo";
      userChrome = (builtins.readFile ./userChrome.css);
      settings = {
        "browser.download.useDownloadDir" = "false";
        "browser.startup.homepage" = "https://www.duckduckgo.com/";
      };
      extraConfig = ''
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("privacy.globalprivacycontrol.enabled", true);
        user_pref("privacy.donottrackheader.enabled", true);
        user_pref("app.shield.optoutstudies.enabled", false);
        user_pref("middlemouse.paste", false);
      '';
    };
  };
}
