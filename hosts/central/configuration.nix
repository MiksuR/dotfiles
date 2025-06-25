{ config, lib, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 ];

  environment.systemPackages = with pkgs; [
    openseachest
    libreoffice
  ];

  programs = {
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      windowManager.xmonad.enable = true;
      displayManager.gdm.enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh.enable = true;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.hasklug
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;

  fileSystems."/imgr" = {
    device = "/dev/disk/by-uuid/a61df710-917c-47b6-bb14-d1701b21deae";
    fsType = "ext4";
    options = [
      "nofail"
      "noauto"
      "lazytime"
      "owner"
    ];
  };
}

