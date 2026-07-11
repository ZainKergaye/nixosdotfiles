{
  description = "Hyprland system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim-custom.url = "github:ZainKergaye/nixvim_dotfiles";
    fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=3678b193efa1e06aab86058aecee18ddaa8878d2";
    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  nixConfig = {
    extra-substituters = [
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://zain-system-cache.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "zain-system-cache.cachix.org-1:SeD9jt2CDJdXCMIejMDlpSrs8pgZJM7Q0vDBrATDQpk="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      mkHost =
        hostName: extraModules:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs lib; };
          modules = [
            ./hosts/${hostName}/configuration.nix
            ./variables.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              networking.hostName = hostName;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.khabib = import ./home.nix;
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations.thinkpad = mkHost "thinkpad" [
        #./modules/hyprland
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        inputs.fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
      ];

      nixosConfigurations.asus = mkHost "asus" [ ];
      # Add any other host here when needed

      homeConfigurations.khabib = home-manager.lib.homeManagerConfiguration {
        # standalone home-manager config for non nixos hosts
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
        ];
      };
    };
}
