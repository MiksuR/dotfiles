{
  description = "System configuration for old-faithful";

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  {
    nixosConfigurations.old-faithful = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.miika = import ./miika.nix;
          home-manager.users.saara = import ./saara.nix;
        }
      ];
    };
  };
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
