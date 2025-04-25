{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vim
      git
      tree
      ripgrep
      fd
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
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.hasklug
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
}

