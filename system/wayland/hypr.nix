# Hyprland config imported into configuration
{
  pkgs,
  lib,
  ...
}:
{
  imports = [

    ./waydroid.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  services.udev.packages = [ pkgs.swayosd ];

  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc.";
    documentation = [ "https://github.com/ErikReider/SwayOSD" ];
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];
    after = [ "graphical.target" ];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };

  environment.systemPackages = with pkgs; [
    # Status bar
    waybar

    # Notifications
    dunst
    libnotify

    # Wallpaper
    swww # Backend

    # Network
    networkmanagerapplet
    networkmanager_dmenu

    # A/V helper
    wireplumber
    xwayland
    wayland-scanner
    hyprwayland-scanner
    swayosd

    # Theme
    glib
    adwaita-icon-theme
    adwaita-qt
    ant-theme

    # Locking / Sleeping
    hyprlock

    # Screenshots
    hyprshot
    grim
    slurp

    xwayland
  ];

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      lib.mkForce [
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
