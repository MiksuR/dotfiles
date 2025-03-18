{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.graphics.enable32Bit = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "dvorak";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
