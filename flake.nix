{
  description = "Hyprland system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixvim-custom.url = "github:ZainKergaye/nixvim_dotfiles";

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
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      nixos-hardware,
      nix-colors,
      nixos-unstable-small,
      nixvim-custom,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixos-unstable-small.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ];
        };
      };

      homeConfigurations = {
        khabib = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # What is the diff between inherit and extraSpecialArgs inherit?
          extraSpecialArgs = {
            inherit nix-colors;
            inherit unstable;
            inherit nixvim-custom;
          };
          modules = [
            ./home.nix
            nixvim.homeModules.nixvim
          ];
        };
      };
    };
}
