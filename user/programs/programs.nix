# Imported into home-manager
{ pkgs
, zen-browser
, ...
}: {
  imports = [
    ./alacritty.nix
    ./cava.nix
    ./peaclock.nix
    ./nixvim/nixvim.nix
    ./kitty.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    firefox
    #zapzap
    vesktop
    prusa-slicer
    zen-browser.packages."x86_64-linux".default
  ];

  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "zoom"
  #   ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
