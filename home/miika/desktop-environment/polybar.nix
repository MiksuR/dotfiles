{ pkgs, ... }:

let
  background-col = "#1F1F1F";
  foreground-col = "#FFFFFF";
  foreground-alt = "#FFFFFF";

  orange1 = "#F06D00";
  orange1-alt = "#FF8D2E";
  orange2 = "#FF7400";

  cyan1 = "#00C1C1";
  cyan2 = "#00B5B5";
  cyan3 = "#00A8A8";
  cyan4 = "#009C9C";
  cyan5 = "#009090";
  cyan6 = "#008585";
  cyan7 = "#007B7B";
  cyan8 = "#007070";

  gleft = "";
  gright = "";

  network-base = {
    type = "internal/network";
    interval = 5;
    format = {
      connected = "<label-connected>";
      disconnected = "";
      connected-background = cyan4;
      disconnected-background = cyan4;
      connected-padding = 1;
      disconnected-padding = 1;
    };
  };
in

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override { pulseSupport = true; };
    script = "polybar-msg cmd quit;polybar &";
  };

  services.polybar.settings = {
    "bar/bar" = {
      width = "100%";
      height = "18pt";
      radius = 0;

      background = "#00000000";
      foreground = "#FFFCE3";

      padding = 0;
      module-margin = 0;
      separator = "";

      font = [
        "Hasklug Nerd Font:style=Medium:size=11;3"
        "Hasklug Nerd Font Mono:style=Regular:antialias=false:size=18;5"
        "Hasklug Nerd Font Mono:style=Regular:size=18;5"
      ];

      modules = {
        left = "left1 xworkspaces left2 left3";
        #left = "left1 xworkspaces left2 spot-on spot-on-previous spot-on-playpause spot-on-next left3";
        right = "right8 right7 memory right6 cpu right5 wlan eth right4 pulseaudio right3 battery right2 date right1";
        #right = "right8 updates right7 memory right6 cpu right5 wlan eth right4 pulseaudio right3 battery right2 date right1";
      };

      enable.ipc = true;
    };

    "settings" = {
      screenchange.reload = true;
      pseudo.transparency = false;
    };

    "module/xworkspaces" = {
      type = "internal/xworkspaces";
      label = {
        active = {
          text = "%name%";
          background = orange1-alt;
          underline = "";
          padding = 1;
        };
        occupied = {
          text = "%name%";
          background = orange1;
          padding = 1;
        };
        empty = {
          text = "%name%";
          foreground = "#FFA65D";
          background = orange1;
          padding = 1;
        };
      };
    };
    "module/spot-on" = {}; # TODO
    "module/spot-on-previous" = {};
    "module/spot-on-playpause" = {};
    "module/spot-on-next" = {};
    "module/memory" = {
      type = "internal/memory";
      interval = 2;
      format = {
        text = "<label>";
        prefix = " ";
        background = cyan6;
        padding = 1;
      };
      label = "%percentage_used%%";
    };
    "module/cpu" = {
      type = "internal/cpu";
      interval = 2;
      format = {
        prefix = " ";
        background = cyan5;
        padding = 1;
      };
      label = "%percentage:2%%";
    };
    "module/wlan" = network-base // {
      interface-type = "wireless";
      label-connected = " %essid%";
    };
    "module/eth" = network-base // {
      interface-type = "wired";
      label-connected = "󰈀 %local_ip%";
    };
    "module/pulseaudio" = {
      type = "internal/pulseaudio";
      sink = "alsa_output.pci-0000_00_1b.0.analog-stereo";
      use-ui-max = true;
      interval = 5;

      format.volume = {
        text = "<ramp-volume> <label-volume>";
        background = cyan3;
        padding = 1;
      };
      format.muted = {
        text = "<label-muted>";
        background = cyan3;
        padding = 2;
      };

      label.volume = "%percentage%%";
      label.muted = {
        text = "󰖁";
        foreground = foreground-col;
      };

      ramp.volume = [ "󰕿" "󰖀" "󰕾" ];
    };
    "module/battery" = {
      type = "internal/battery";
      full.at = 99;
      low.at = 10;
      poll.interval = 2;
      time.format = "%H:%M";

      battery = "BAT1";
      adapter = "ACAD";

      format = {
        charging = {
          text = "<animation-charging> <label-charging>";
          background = cyan2;
          padding = 1;
        };
        discharging = {
          text = "<ramp-capacity> <label-discharging>";
          background = cyan2;
          padding = 1;
        };
        full = {
          text = "<label-full>";
          background = cyan2;
          padding = 1;
        };
        low = {
          text = "<ramp-capacity> <label-low>";
          foreground = "#FF0030";
          background = cyan2;
          padding = 1;
        };
      };
      label = {
        low = " %percentage%% ";
        charging = " %percentage%% ";
        discharging = " %percentage%% ";
        full = " ";
      };
      ramp.capacity = [ "" "" "" "" "" ];
      animation.charging = {
        text = [ "" "" "" "" ];
        framerate = 750;
      };
    };
    "module/date" = {
      type = "internal/date";
      interval = 1;

      date = "%H:%M";
      date-alt = "%Y-%m-%d %H:%M:%S";

      label = "%date%";
      label-background = cyan1;
    };

    # Glyphs
    "module/left1" = {
      type = "custom/text";
      content-background = "#00000000";
      content-foreground = orange1;
      content = gright;
      content-font = 2;
    };
    "module/left2" = {
      type = "custom/text";
      content-background = orange1;
      content-foreground = orange2;
      content = gright;
      content-font = 2;
    };
    "module/left3" = {
      type = "custom/text";
      content-background = "#00000000";
      content-foreground = orange2;
      content = gleft;
      content-font = 2;
    };

    "module/right1" = {
      type = "custom/text";
      content-background = "#00000000";
      content-foreground = cyan1;
      content = gleft;
      content-font = 2;
    };
    "module/right2" = {
      type = "custom/text";
      content-background = cyan2;
      content-foreground = cyan1;
      content = gright;
      content-font = 2;
    };
    "module/right3" = {
      type = "custom/text";
      content-background = cyan3;
      content-foreground = cyan2;
      content = gright;
      content-font = 2;
    };
    "module/right4" = {
      type = "custom/text";
      content-background = cyan4;
      content-foreground = cyan3;
      content = gright;
      content-font = 2;
    };
    "module/right5" = {
      type = "custom/text";
      content-background = cyan5;
      content-foreground = cyan4;
      content = gright;
      content-font = 2;
    };
    "module/right6" = {
      type = "custom/text";
      content-background = cyan6;
      content-foreground = cyan5;
      content = gright;
      content-font = 2;
    };
    "module/right7" = {
      type = "custom/text";
      content-background = cyan7;
      content-foreground = cyan6;
      content = gright;
      content-font = 2;
    };
    "module/right8" = {
      type = "custom/text";
      content-background = "#00000000";
      content-foreground = cyan7;
      content = gright;
      content-font = 2;
    };
    "module/right9" = {
      type = "custom/text";
      content-background = "#00000000";
      content-foreground = cyan8;
      content = gright;
      content-font = 2;
    };
  };
}
