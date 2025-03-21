{ config, pkgs, hostName, ... }:

{
  home.username = "miika";
  home.homeDirectory = "/home/miika";
  home.sessionVariables = {
    EDITOR = "vim";
    KEYTIMEOUT=1;
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
    ".config/run-recent".source = ./suckless/dmenu/run-recent;
    ".config/zsh-custom/themes/rankaviita.zsh-theme".source = ./zsh/rankaviita.zsh-theme;
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
    zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "cabal" "colored-man-pages" "colorize" "command-not-found" "stack" "timer" ];
        theme = "rankaviita";
        custom = "$HOME/.config/zsh-custom";
      };

      initExtra = ''
        stty erase 
        
        bindkey -v
        bindkey '^?' backward-delete-char
        bindkey '^r' history-incremental-search-backward
        bindkey '^u' kill-whole-line
        bindkey '^e' end-of-line
        
        function zle-line-init zle-keymap-select {
          VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
          RPS1="''${''${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
          zle reset-prompt
        }
        zle -N zle-line-init
        zle -N zle-keymap-select
      '';
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
