# Hyprland config imported into configuration
{ pkgs
, lib
, ...
}: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; let
    restart-swayidle = lib.getExe (pkgs.writeShellScriptBin "restart-swayidle" ''
       	pkill swayidle
         hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
      hyprctl --instance 0 'dispatch exec swaylock'
    '');
  in
  [
    # Status bar
    waybar
    (
      waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

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

    # Theme
    glib
    adwaita-icon-theme
    adwaita-qt
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
