{ pkgs, ... }: {
  imports = [
    ./idle.nix
    ./rofi.nix
    ./dunst.nix
    ./waybar.nix
    ./wlogout.nix
    ./pyprland.nix
    ./swaylock.nix
  ];
  home.packages = with pkgs; [
    # Wallpaper
    waypaper # GUI

    # Audio
    pwvucontrol

    # System info viewer
    hyprsysteminfo

    # Screenshot drawing tool
    swappy # TODO: Integrate into screenshots
  ];
}
