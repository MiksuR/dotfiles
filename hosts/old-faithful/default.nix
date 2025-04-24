{ config, lib, pkgs, ... }:

{
  imports = [
    ../common
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "old-faithful";
  networking.networkmanager.enable = true;

  users.users = {
    miika = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    saara.isNormalUser = true;
  };
  home-manager.users.miika = import ../../home/miika;
  home-manager.users.saara = import ../../home/saara;

  system.stateVersion = "24.11";
}
