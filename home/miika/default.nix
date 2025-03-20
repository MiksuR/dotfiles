{ config, pkgs, hostName, ... }:

{
  home.username = "miika";
  home.homeDirectory = "/home/miika";
  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
    alacritty
    (pkgs.dmenu.overrideDerivation (oldAttrs: rec {
      version = "5.2";
      src = pkgs.fetchurl {
        url = "https://dl.suckless.org/tools/dmenu-5.2.tar.gz";
        sha256 = "sha256-1NTKd7WRQPJyJy21N+BbuRpZFPVoAmUtxX5hp3PUN5I=";
      };
      patches = [
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/border/dmenu-border-5.2.diff";
          sha256 = "sha256-pf9UM3cEVfYr99HuQeeakYbFNSAJmCPS+uqSI6Anf/I=";
        })

        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-5.2.diff";
          sha256 = "sha256-g7ow7GVUsisR2kQ4dANRx/pJGU8fiG4fR08ZkbUFD5o=";
        })
      ];
      configFile = ./suckless/dmenu/config.def.h;
      postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h";
    }))
    pkgs.xclip
    # # For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/run-recent".source = ./suckless/dmenu/run-recent;
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userEmail = "8172649+MiksuR@users.noreply.github.com";
      userName = "Miksu Rankaviita";
      # signing.key = "AD181E25DBF8D214";
      # extraConfig.commit.gpgsign = true;
    };
    gpg.enable = true;
    firefox = {
      enable = true;
      profiles.default = {
        search.default = "DuckDuckGo";
        userChrome = (builtins.readFile ./firefox/userChrome.css);
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
  };

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad/xmonad.hs;
    };
  };

  home.keyboard = {
    layout = "fi";
    model = "pc104";
    variant = "fidvorak";
    options = [ "caps:backspace" ];
  };

  home.stateVersion = "24.11";
}
