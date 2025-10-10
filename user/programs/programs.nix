# Imported into home-manager
{ pkgs
, lib
, zen-browser
, nixvim-custom
, ...
}: {
  imports = [
    ./cava.nix
    ./peaclock.nix
    ./fastfetch.nix
    ./git.nix
    ./quartus.nix
  ];

  home.packages = with pkgs; [
    zapzap
    vesktop
    prusa-slicer
    bitwarden-desktop
    zen-browser.packages."x86_64-linux".default
    notepad-next
    qbittorrent
    syncthing
    youtube-music
    libreoffice
    inkscape
    p3x-onenote
    syncthingtray
    ungoogled-chromium
    hakuneko

    # games
    osu-lazer-bin
    atlauncher

    # Astrophotography
    gimp
    siril
    rawtherapee

    #skewl
    #asciidoctor-with-extensions
    kicad

    # cli tools
    nixvim-custom.packages."x86_64-linux".default
    onefetch
    cmatrix
    cbonsai

    rpi-imager
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "quartus-prime-lite"
      "quartus-prime-lite-dark" # Look at quartus.nix
      "quartus-prime-lite-unwrapped"
    ];
}
