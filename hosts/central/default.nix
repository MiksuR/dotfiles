{ config, lib, pkgs, ... }:

{
  imports = [
    ../common
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  users.users = {
    miika = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    saara.isNormalUser = true;
    games.isNormalUser = true;
  };
  home-manager.users.miika = import ../../home/miika;
  home-manager.users.saara = import ../../home/saara;
  home-manager.users.games = import ../../home/games;

  system.stateVersion = "24.11";
}
