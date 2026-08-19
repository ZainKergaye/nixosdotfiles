{
  pkgs,
  lib,
  config,
  headless,
  ...
}:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./zen-browser.nix
    ./quartus.nix
    # both are disabled if headless variable is set
  ];

  home.packages =
    with pkgs;
    lib.mkIf (!headless) [
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
