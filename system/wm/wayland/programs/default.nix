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
  ];
}
