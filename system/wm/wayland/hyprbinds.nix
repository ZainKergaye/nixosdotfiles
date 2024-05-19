{...}: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:273, resizewindow"
      "$mod, mouse:272, movewindow"
    ];

    bindl = [ # Laptop lid actions
      #", switch:24ffa00, exec, swaylock"
      #", switch:on:24ffa00, exec, swaylock"
    ];

    bind =
      [
        "$mod, H, movefocus, l" # Not used
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$mod, F, exec, chromium"
        "$mod, Q, exec, kitty"

        "$mod, C, killactive"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"

        "$mod, SPACE, exec, rofi -show drun"

        "$mod CTRL, I, togglespecialworkspace, magic"
        "$mod CTRL SHIFT, I, movetoworkspace, special:magic"

        "$mod, M, exit"
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
