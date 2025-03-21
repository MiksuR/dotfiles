{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    shadow = true;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "_GTK_FRAME_EXTENTS@:c"
      "class_g = 'firefox' && argb"
    ];
    shadowOffsets = [ (-7) (-7) ];
    fade = false;
    inactiveOpacity = 0.95;
    vSync = true;

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        opacity = 0.75;
        focus = true;
        full-shadow = false;
      };
      dock = { shadow = false; clip-shadow-above = true; };
      dnd = { shadow = false; };
      popup_menu = { opacity = false; };
      dropdown_menu = { opacity = false; };
    };

    settings = {
      shadow-radius = 7;
    };
  };

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
