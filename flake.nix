{
  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      nixosConfigurations = {
        odev = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/odev/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users = {
                naix = import ./users/naix.nix;
                larry = import ./users/larry.nix;
              };
            }
          ];
          specialArgs = {
            inherit system inputs;
          };
        };
      };
      
      homeManagerConfigurations = {
        naix = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;          

          modules = [
            ./users/naix.nix
          ];

          extraSpecialArgs = {
            inherit system;
          };
        };
        
        larry = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;          

          modules = [
            ./users/larry.nix
          ];

          extraSpecialArgs = {
            inherit system;
          };
        };
      };
    };
}
