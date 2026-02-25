{ config, lib, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 8000 ];

  environment.systemPackages = with pkgs; [
    cifs-utils
    openseachest
    libreoffice
    kdePackages.gwenview
    inkscape
    duc
    vlc
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
      windowManager.xmonad.enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    desktopManager.plasma6.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.hasklug
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.Policy.AutoEnable = true;
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowSuspendThenHibernate=no
    AllowHybridSleep=no
  '';

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

  fileSystems."/mnt/dietpi" = {
    device = "//dietpi.lan/dietpi";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/home/miika/private/smb-secrets,uid=1000,gid=100"]; # Change hardcoded values
  };
}

