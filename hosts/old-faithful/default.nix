{ config, lib, pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.graphics.enable32Bit = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "dvorak";

  networking.hostName = "old-faithful";
  networking.networkmanager.enable = true;

  users.users = {
    miika = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    saara.isNormalUser = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}
