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
    zapzap
    vesktop
    prusa-slicer
    bitwarden-desktop
    osu-lazer-bin

    (pkgs.zoom-us.overrideAttrs {
      version = "6.2.11.5069";
      src = pkgs.fetchurl {
        url = "https://zoom.us/client/6.2.11.5069/zoom_x86_64.pkg.tar.xz";
        hash = "sha256-k8T/lmfgAFxW1nwEyh61lagrlHP5geT2tA7e5j61+qw=";
      };
    })

    gimp
    siril
    rawtherapee

    quartus-prime-lite
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "zoom-us"
      "zoom"
      "quartus-prime-lite-unwrapped"
      "quartus-prime-lite"
    ];
}
