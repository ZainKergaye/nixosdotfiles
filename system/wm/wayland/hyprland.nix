# Hyprland config for home-manager
{...}: {
  imports = [
    ./hyprbinds.nix
    ./dunst.nix
    ./waybar.nix
    #./swayidle.nix
    #./swaylock.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        ", preferred, auto, 1"
				"desc:LG Display 0x0521, 1920x1080@60.02, 0x0, 1" # Built-in display
        "desc:Acer Technologies VG270 TEGAA003851S, 1920x1080@74.97, -1920x0, 1" # Room Display
				"desc:Samsung Electric Company S34J55x H4LNB01778, 3440x1440@49.99, -760x-1620, 1" # Office display
      ];

      windowrule = [
        "float,^(Save File)$" # BUG: Not implemented correctly
        "float,^(Pipewire Volume Control)$"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "col.active_border, rgba(33ccffee) rgba(00ff99ee) 45deg"
        "col.inactive_border, rgba(595959aa)"
        "col.shadow, rgba(1a1a1aee)"
        "natural_scroll, true"
      ];

      exec-once = [
        "nm-applet"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" # DEP I think
        "waybar"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        resize_on_border = true;

        layout = "dwindle";
      };
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

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
