{ pkgs, ... }: {
  # HELP: Does not currently work
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      ignore_dbus_inhibit = false             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
    }

    listener {
      timeout = 600     # 10min
      on-timeout = ${pkgs.swaylock}/bin/swaylock
      on-resume = ${pkgs.dunst}/bin/dunstify "Hi aegis 🍃" "Welcome Back  ʕっ•ᴥ•ʔっ"
    }

    listener {
      timeout = 1800        # 30min
      on-timeout = ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
      on-resume = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
    }

    listener {
      timeout = 3600
      on-timeout = systemctl suspend
    }
  '';
}
