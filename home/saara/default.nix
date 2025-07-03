{ config, pkgs, ... }:

{
  imports = [ ./wine.nix ];

  home.username = "saara";
  home.homeDirectory = "/home/saara";

  home.packages = with pkgs; [
    darktable
    chromium
    firefox
  ];

  programs = {
    home-manager.enable = true;
  };

  xsession.enable = true;
  xsession.windowManager.command = "startplasma-x11";

  home.stateVersion = "24.11";
}
