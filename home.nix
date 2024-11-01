{ config, pkgs, ... }:

{
  home.username = "miika";
  home.homeDirectory = "/home/miika";
  home.stateVersion = "24.05";

  home.packages = [
    # # configuration. For example, this adds a command 'my-hello' to your
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
}

