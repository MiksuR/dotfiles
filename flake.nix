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
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.miika = import ./miika.nix;
            home-manager.users.saara = import ./saara.nix;
          }
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
