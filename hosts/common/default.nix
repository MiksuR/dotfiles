{ config, lib, pkgs, nixpkgs-6de7e2, hostName, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.graphics.enable32Bit = true;

  networking.hostName = hostName;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "dvorak";

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment = {
    shells = [ pkgs.zsh ];
    pathsToLink = [ "/share/zsh" ];
    variables = { EDITOR = "vim"; };
    systemPackages = with pkgs; [
      vim git
      tree ripgrep
      fd
      unzip p7zip
    ];
  };

  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit nixpkgs-6de7e2;
    inherit hostName;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
