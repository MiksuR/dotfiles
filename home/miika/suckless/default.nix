{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.dmenu.overrideDerivation (oldAttrs: rec {
      version = "5.2";
      src = pkgs.fetchurl {
        url = "https://dl.suckless.org/tools/dmenu-5.2.tar.gz";
        sha256 = "sha256-1NTKd7WRQPJyJy21N+BbuRpZFPVoAmUtxX5hp3PUN5I=";
      };
      patches = [
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/border/dmenu-border-5.2.diff";
          sha256 = "sha256-pf9UM3cEVfYr99HuQeeakYbFNSAJmCPS+uqSI6Anf/I=";
        })

        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-5.2.diff";
          sha256 = "sha256-g7ow7GVUsisR2kQ4dANRx/pJGU8fiG4fR08ZkbUFD5o=";
        })
      ];
      configFile = ./dmenu/config.def.h;
      postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h";
    }))
  ];

  home.file = {
    ".config/run-recent".source = ./dmenu/run-recent;
  };
}
