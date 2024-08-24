{
  description = "Home Manager configuration of zain";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    nixos-hardware,
    nix-colors,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      conduit = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };

    homeConfigurations = {
      aegis = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit nix-colors;};
        modules = [
          ./home.nix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}
