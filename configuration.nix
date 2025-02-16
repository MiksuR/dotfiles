{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.graphics.enable32Bit = true;

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "dvorak";

  networking.hostName = "old-faithful"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  users.users = {
    miika = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    saara.isNormalUser = true;
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      git
      tree
    ];
    variables = {
      EDITOR = "vim";
    };
  };

  services = {
    xserver.enable = true;
    xserver.desktopManager.plasma5.enable = true;
    xserver.windowManager.xmonad.enable = true;
    xserver.displayManager.gdm.enable = true;
    libinput.enable = true; # Touchpad support
    pipewire.enable = true;
    pipewire.pulse.enable = true;
  };
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}

