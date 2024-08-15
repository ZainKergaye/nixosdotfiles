{...}: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:273, resizewindow"
      "$mod, mouse:272, movewindow"
    ];

    bindl = [
      # Laptop lid actions
      ", switch:24ffa00, exec, swaylock"
      ", switch:on:24ffa00, exec, swaylock"
    ];

    binde = [
      # binde repeats command while being help
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
	  ",XF86MonBrightnessUp, exec, brightnessctl s 80+"
	  ",XF86MonBrightnessDown, exec, brightnessctl s 80-"
    ];

    bind =
      [
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$mod CTRL, L, exec, swaylock"

        "$mod, W, exec, chromium"
        "$mod, Q, exec, kitty"

        "$mod, C, killactive"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, S, togglesplit"
        "$mod, G, toggleopaque"

        "$mod, SPACE, exec, rofi -show drun"

        "$mod CTRL, I, togglespecialworkspace, magic"
        "$mod CTRL SHIFT, I, movetoworkspace, special:magic"

        "$mod CTRL, O, togglespecialworkspace, hidden"
        "$mod CTRL SHIFT, O, movetoworkspace, special:hidden"

        "$mod CTRL, U, togglespecialworkspace, magicone"
        "$mod CTRL SHIFT, U, movetoworkspace, special:magicone"

        "$mod CTRL, P, togglespecialworkspace, hiddenone"
        "$mod CTRL SHIFT, P, movetoworkspace, special:hiddenone"

        ",Print, exec, hyprshot -m output -o /home/aegis/Pictures/screenshots"
        ",XF86Launch2, exec, hyprshot -m region -o /home/aegis/Pictures/screenshots"

        "$mod CTRL SHIFT, M, exit"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
}
