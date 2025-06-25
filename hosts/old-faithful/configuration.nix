{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [];

  services = {
    xserver.enable = true;
    xserver.windowManager.xmonad.enable = true;
    libinput.enable = true; # Touchpad support
    pipewire.enable = true;
    pipewire.pulse.enable = true;
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.hasklug
  ];
  fonts.fontconfig.useEmbeddedBitmaps = true;
}

