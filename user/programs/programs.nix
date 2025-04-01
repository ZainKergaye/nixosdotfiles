# Imported into home-manager
{ pkgs
, lib
, zen-browser
, config
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

    # Astrophotography
    gimp
    siril
    rawtherapee

    #skewl
    quartus-prime-lite
    asciidoctor-with-extensions
    kicad

    # cli tools
    onefetch
    cmatrix
    cbonsai

    rpi-imager

    # Productivity focusing
    ianny
  ];

  wayland.windowManager.hyprland.settings.exec-once = [ "${pkgs.ianny}/bin/ianny" ];

  # Quartus prime variables
  home.sessionVariables.LM_LICENSE_FILE = "/home/${config.variables.username}/.dotfiles/secrets/LR-214324_License.dat";
  home.sessionVariables.NUM_PARALLEL_PROCESSORS = "4";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "osu-lazer-bin"
      "quartus-prime-lite-unwrapped"
      "quartus-prime-lite"
    ];
}
