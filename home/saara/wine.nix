{ nixpkgs-6de7e2, ... }:

{
  home.packages = [
    (nixpkgs-6de7e2.wineWow64Packages.unstableFull.overrideAttrs(past: {
      src = nixpkgs-6de7e2.fetchFromGitLab {
        domain = "gitlab.winehq.org";
        owner = "ElementalWarrior";
        repo = "wine";
        rev = "a7c9b19e1a26cf49c63a7c19189a3e2bbe2c6ac2";
        hash = "sha256-XVhz9p2kgFBoJ376vg8OaFXxcMEjAe9AK1hk0I1rb1Q=";
      };
      postInstall = "ln -s \"$out/bin/wine\" \"$out/bin/wine64\"";
    }))
    (nixpkgs-6de7e2.winetricks.overrideAttrs(past: rec {
      src = nixpkgs-6de7e2.fetchFromGitLab {
        owner = "Winetricks";
        repo = "winetricks";
        rev = "20250102";
        hash = "sha256-Km2vVTYsLs091cjmNTW8Kqku3vdsEA0imTtZfqZWDQo=";
      };
      version = src.rev;
    }))
  ];
}
