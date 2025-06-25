{ config, pkgs, ... }:

{
  home.username = "games";
  home.homeDirectory = "/home/games";

  home.packages = with pkgs; [
    lutris
  ];

  programs = {
    home-manager.enable = true;
    mangohud.enable = true;
  };

  xsession = {
    enable = true;
    windowManager.command = "startplasma-x11";
  };

  home.stateVersion = "24.11";
}
