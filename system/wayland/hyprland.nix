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
        "desc:Samsung Electric Company S34J55x H4LNB01778, 3440x1440@74.98, -760x-1440, 1" # Office display
        "desc:Dell Inc. DELL U3415W PXF7986G10HL, preferred, auto-up, 1" # Campus library display
        "desc:Ancor Communications Inc VS278 J9LMQS077400, preferred, auto-up, 1" # Eng display
        "desc:Sharp Corporation SHARP HDMI, preferred, auto-up, 1, mirror, eDP-1"
      ];

      windowrule = [
        # "float, size 530 400,title:(Bluetooth Devices)"
        #
        # "float, size 700 550,title:(Save File)"
        # "float, size 700 550,title:(Open File)"
        #
        # "opacity 0.8 0.8, class:^(vesktop)$"
        "match:initial_title ^(kitty), opacity 0.8 0.8"

        "match:tag op100, opacity 1 1"
        "match:tag op80, opacity 0.8 0.8"
        "match:tag op60, opacity 0.6 0.6"
        "match:title ^Open File$, float on, center on "
        "match:title ^Save File$, float on, center on "
        # "center, title:^Open File$"
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

      input = {
        accel_profile = "custom 0.2144477506 0.000 0.307 0.615 1.077 1.539 2.002 2.505 3.208 3.910 4.613 5.315 6.018 6.720 7.423 8.125 8.828 9.530 10.233 10.935 12.387";

        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          clickfinger_behavior = true;
          scroll_factor = 0.3;
        };
      };

      exec-once = [
        "nm-applet"
        "waybar"
        "blueman-applet"
        "syncthingtray --wait"
        "awww-daemon"
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
          "windowsIn, 1, 7, winIn, slide"
          "windowsOut, 1, 3, smoothOut, slide"
          "windowsMove, 1, 7, winIn, slide"
          "workspacesIn, 1, 8, winIn, slide"
          "workspacesOut, 1, 8, winOut, slide"
          "layersIn, 1, 10, winIn, slide"
          "layersOut, 1, 3, layerOut, popin 50%"
        ];
        bezier = [
          "winIn, 0.1, 1.0, 0.1, 1.0"
          "winOut, 0.1, 1.0, 0.1, 1.0"
          "smoothOut, 0.5, 0, 0.99, 0.99"
          "layerOut,0.23,1,0.32,1"
        ];
      };

      dwindle.preserve_split = true;
    };
  };
}
