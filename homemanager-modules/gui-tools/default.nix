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

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          zen = "zen.desktop";
          image = "org.gnome.Loupe.desktop";
        in
        {
          "x-scheme-handler/http" = zen;
          "x-scheme-handler/https" = zen;
          "x-scheme-handler/about" = zen;
          "x-scheme-handler/unknown" = zen;
          "text/html" = zen;
          "images/png" = image;
          "images/jpg" = image;
          "images/webp" = image;
          "images/svg+xml" = image;
          "images/jpeg" = image;
          "application/pdf" = "org.gnome.Evince.desktop";
          "x-scheme-handler/discord" = "vesktop.desktop";
        };
    };
  };
}
