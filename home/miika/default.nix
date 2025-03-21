{ config, pkgs, hostName, ... }:

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

  home.packages = with pkgs; [
    pkgs.xclip
    # # For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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
  };

  home.keyboard = {
    layout = "fi";
    model = "pc104";
    variant = "fidvorak";
    options = [ "caps:backspace" ];
  };

  home.stateVersion = "24.11";
}
