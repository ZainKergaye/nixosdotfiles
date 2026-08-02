# Imported into home-manager
{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./zen-browser.nix
    #./quartus.nix
  ];

  home.packages = with pkgs; [
    vesktop
    prusa-slicer
    qbittorrent
    pear-desktop
    libreoffice
    inkscape
    p3x-onenote
    ungoogled-chromium
    zoom-us
    freecad

    # games
    hmcl

    #skewl
    kicad
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "quartus-prime-lite"
      "quartus-prime-lite-dark" # Look at quartus.nix
      "quartus-prime-lite-unwrapped"
      "zoom"
    ];
}
