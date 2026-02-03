{ pkgs, ... }:
{
  imports = [
    ./idle.nix
    ./rofi.nix
    ./dunst.nix
    ./waybar.nix
    ./wlogout.nix
    ./pyprland.nix
    ./swayosd.nix
    ./hyprlock.nix
  ];
  home.packages = with pkgs; [
    # Wallpaper
    waypaper # GUI

    # Audio
    pwvucontrol

    # System info viewer
    hyprsysteminfo

    # Screenshot drawing tool
    swappy

    hyprpolkitagent # GUI auth
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now hyprpoltikagent.service"
  ];
}
