{
  description = "Home Manager configuration of zain";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };

      homeConfigurations = {
        zain = home-manager.lib.homeManagerConfiguration {
          
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
