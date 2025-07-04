{ config, lib, pkgs, ... }:

{
  imports = [
    ../common
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  networking.networkmanager.enable = true;

  users.users = {
    miika = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
  home-manager.users.miika = import ../../home/miika;

  system.stateVersion = "24.11";
}
