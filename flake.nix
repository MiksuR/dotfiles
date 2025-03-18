{
  description = "MiksuR system config";

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    hosts = builtins.readDir ./hosts;
    mkHost = (host: type_:
      lib.nixosSystem {
        system = "x86_64-linux";
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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
