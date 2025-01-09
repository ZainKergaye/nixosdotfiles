# Imported into home-manager
{ pkgs
, lib
, ...
}: {
  imports = [
    ./cava.nix
    ./peaclock.nix
    ./nixvim/nixvim.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    firefox
    zapzap
    vesktop
    prusa-slicer
    bitwarden-desktop
    osu-lazer-bin
    zoom-us
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "zoom-us"
      "zoom"
    ];
}
