{
  description = "MiksuR system config";

  outputs = { self, nixpkgs, nixpkgs-6de7e2, home-manager, ... }@inputs:
  let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    hosts = builtins.readDir ./hosts;
    mkHost = (host: type_:
      lib.nixosSystem {
        inherit system;
        specialArgs = {
          hostName = host;
          nixpkgs-6de7e2 = import nixpkgs-6de7e2 { inherit system; };
        };
        modules = [
          ./hosts/${host}
          home-manager.nixosModules.home-manager
        ];
      }
    );
  in
  {
    nixosConfigurations = builtins.mapAttrs mkHost hosts;
  };
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Pinned nixpkgs for ElementalWarrior wine fork
    nixpkgs-6de7e2.url = "github:NixOS/nixpkgs/6de7e2e9f6eeb4b4784bf376f07293f0d2748004";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
