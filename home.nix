{ config, pkgs, nixgl, ... }:

{
  home.username = "miika";
  home.homeDirectory = "/home/miika";
  home.stateVersion = "24.05";

  home.packages = [
    (config.lib.nixGL.wrap pkgs.alacritty)
    (pkgs.dmenu.overrideDerivation (oldAttrs: rec {
      version = "5.2";
      src = pkgs.fetchurl {
        url = "https://dl.suckless.org/tools/dmenu-5.2.tar.gz";
        sha256 = "sha256-1NTKd7WRQPJyJy21N+BbuRpZFPVoAmUtxX5hp3PUN5I=";
      };
      patches = [
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/border/dmenu-border-5.2.diff";
          sha256 = "0kyi50z6c1y81gbq4kp9cnmg7gqpc9j17r7x227v6px68a8nj7p5";
        })

        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-5.2.diff";
          sha256 = "1jck88ypx83b73i0ys7f6mqikswgd2ab5q0dfvs327gsz11jqyws";
        })
      ];
      configFile = pkgs.writeText "config.def.h" (builtins.readFile ./suckless/dmenu/config.def.h);
    }))
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

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
  programs.vim.enable = true;
  programs.git = {
    enable = true;
    userEmail = "8172649+MiksuR@users.noreply.github.com";
    userName = "Miksu Rankaviita";
    signing.key = "AD181E25DBF8D214";
    extraConfig.commit.gpgsign = true;
  };
  programs.gpg.enable = true;

  nixGL.packages = nixgl.packages.${pkgs.system};
  nixGL.defaultWrapper = "mesa";

  xsession.enable = true;
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config = ./xmonad.hs;
}

