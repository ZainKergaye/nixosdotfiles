{
  description = "Hyprland system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  nixConfig = {
    extra-substituters = [
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  outputs =
    { nixpkgs
    , home-manager
    , nixvim
    , nixos-hardware
    , nix-colors
    , nixos-unstable-small
    , zen-browser
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixos-unstable-small.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
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
          # What is the diff between inherit and extraSpecialArgs inherit?
          extraSpecialArgs = {
            inherit nix-colors;
            inherit unstable;
            inherit zen-browser;
          };
          modules = [
            ./home.nix
            nixvim.homeManagerModules.nixvim
          ];
        };
      };
    };
}
