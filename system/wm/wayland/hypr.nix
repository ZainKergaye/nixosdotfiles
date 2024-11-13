# Hyprland config imported into configuration
{ pkgs
, lib
, ...
}: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # Status bar
    waybar
    (
      waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    # Notificatio
    dunst
    libnotify

    # Wallpaper
    swww # Backend
    waypaper # GUI

    # App Launcher
    rofi-wayland

    # Network
    networkmanagerapplet
    networkmanager_dmenu

    # A/V helper
    wireplumber
    xdg-desktop-portal-hyprland
    xwaylandvideobridge
    xwayland
    pyprland
    wayland-scanner
    hyprwayland-scanner

    # Audio
    pwvucontrol

    # Theme
    glib
    adwaita-icon-theme
    ant-theme

    # Locking / Sleeping
    hyprlock
    swaylock

    # Screenshots
    hyprshot
    grim
    slurp

    xwayland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs;
      lib.mkForce [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
  };

  services.libinput.enable = true; # touchpad
  services.libinput.touchpad.naturalScrolling = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
