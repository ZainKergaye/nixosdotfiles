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
    ./hyprland
  ];

  hyprland-hm-config.enable = lib.mkIf (!headless) true;

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
      bambu-studio
      mission-planner

      # games
      hmcl

      #skewl
      kicad
    ];
}
