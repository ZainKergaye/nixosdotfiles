# Imported into home-manager
{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./cava.nix
    ./peaclock.nix
    ./fastfetch.nix
    ./git.nix
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

    # cli tools
    inputs.nixvim-custom.packages."x86_64-linux".default
    onefetch
    cbonsai
    yazi
  ];
}
