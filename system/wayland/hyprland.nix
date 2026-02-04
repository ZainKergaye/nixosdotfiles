# Hyprland config for home-manager
{ ... }:
{
  imports = [
    ./hyprbinds.nix
    ./colors.nix
    ./programs
    ./scripts
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        # name, resolution, position, scale
        # https://wiki.hyprland.org/Configuring/Monitors/
        ", preferred, auto, 1" # Default
        "desc:LG Display 0x0521, 1920x1080@60.02, 0x0, 1" # Built-in display
        "desc:Acer Technologies VG270 TEGAA003851S, 1920x1080@74.97, -1920x0, 1" # Room Display
        "desc:Samsung Electric Company S34J55x H4LNB01778, 3440x1440@49.99, -760x-1440, 1" # Office display
        "desc:Dell Inc. DELL U3415W PXF7986G10HL, preferred, auto-up, 1" # Campus library display
      ];

			windowrule = [
        # "float, size 530 400,title:(Bluetooth Devices)"
        #
        # "float, size 700 550,title:(Save File)"
        # "float, size 700 550,title:(Open File)"
        #
        # "opacity 0.8 0.8, class:^(vesktop)$"
				"match:initial_title ^(kitty), opacity 0.8 0.8"

				"match:tag opacity_1, opacity 1 1"
				"match:tag opacity_0.8, opacity 0.8 0.8"
				"match:tag opacity_0.6, opacity 0.6 0.6"
      ];

      env = [
        "XCURSOR_SIZE,14"
        "HYPRCURSOR_SIZE,14"

        "natural_scroll, true"
        "QT_QPA_PLATFORMTHEME,qt6ct" # for Qt apps
        "force_default_wallpaper, 1" # Disables anime wallpaper
      ];

      gesture = [
        "3, horizontal, workspace"
      ];

      exec-once = [
        "nm-applet"
        "waybar"
        "blueman-applet"
        "syncthingtray --wait"
        "swww-daemon"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        resize_on_border = true;

        layout = "dwindle";
      };

      misc.key_press_enables_dpms = true;

      animations = {
        enabled = true;
        animation = [
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 8, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle.preserve_split = true;
    };
  };
}
