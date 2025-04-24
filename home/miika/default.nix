{ config, pkgs, hostName, ... }:

let
  gpgKeys = {
    "old-faithful" = "AF910854BA808650";
  };
in
{
  imports = [
    ./desktop-environment
    ./terminal
    ./suckless
    ./firefox
  ];

  home.username = "miika";
  home.homeDirectory = "/home/miika";
  home.sessionVariables = {
    EDITOR = "vim";
    KEYTIMEOUT=1;
  };
  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];

  home.packages = with pkgs; [
    xclip
    obsidian
    emacs
    bitwarden
    # # For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    home-manager.enable = true;
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    gpg.enable = true;
    git = {
      enable = true;
      userEmail = "8172649+MiksuR@users.noreply.github.com";
      userName = "Miksu Rankaviita";
      signing.key = gpgKeys.${hostName};
      extraConfig.commit.gpgsign = true;
    };
  };

  services = {
    ssh-agent.enable = true;
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
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
