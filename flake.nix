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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    nixos-hardware,
    nixpkgs-wayland,
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
          #./system/wm/wayland/default.nix
        ];
      };
    };

    homeConfigurations = {
      aegis = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };

    config = {
      nix.settings = {
        # add binary caches
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        ];
        substituters = [
          "https://cache.nixos.org"
          "https://nixpkgs-wayland.cachix.org"
        ];
      };

      # use it as an overlay
      #nixpkgs.overlays = [inputs.nixpkgs-wayland.overlay];

      # or, pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
      environment.systemPackages = [
        nixpkgs-wayland.packages.${system}.waybar
        nixpkgs-wayland.packages.${system}.swaylock
        nixpkgs-wayland.packages.${system}.wofi
        nixpkgs-wayland.packages.${system}.wshowkeys
      ];
    };
  };
}
