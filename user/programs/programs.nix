# Imported into home-manager
{
  pkgs,
  lib,
  zen-browser,
  nixvim-custom,
  ...
}:
{
  imports = [
    ./cava.nix
    ./peaclock.nix
    ./fastfetch.nix
    ./git.nix
    #./quartus.nix
  ];

  home.packages = with pkgs; [
    vesktop
    prusa-slicer
    zen-browser.packages."x86_64-linux".default
    qbittorrent
    pear-desktop
    libreoffice
    inkscape
    p3x-onenote
    ungoogled-chromium

    # games
    atlauncher

    #skewl
    # kicad

    # cli tools
    nixvim-custom.packages."x86_64-linux".default
    onefetch
    cbonsai

    rpi-imager
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "quartus-prime-lite"
      "quartus-prime-lite-dark" # Look at quartus.nix
      "quartus-prime-lite-unwrapped"
    ];
}
