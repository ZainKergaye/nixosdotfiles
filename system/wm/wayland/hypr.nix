# Hyprland config imported into configuration
{ pkgs, ... }: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  #systemd.user.services."aegis" = {
  #description = "Script to start Hyprland right after login";
  #script = "Hyprland";
  #wantedBy = [ "multi-user.target" ]; # starts after login
  #};
  # BUG: This stops hyprland from starting up

  environment.systemPackages = with pkgs; [
    # Status bar
    waybar
    (
      waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    # Notification
    dunst
    libnotify

    # Wallpaper
    swww

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

    # Cursor
    glib
    adwaita-icon-theme

    # Locking / Sleeping
    hyprlock
    hypridle
    swaylock

    # Screenshots
    hyprshot
    grim
    slurp

    xwayland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  services.libinput.enable = true; # touchpad
  services.libinput.touchpad.naturalScrolling = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
