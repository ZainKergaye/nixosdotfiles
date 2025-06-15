{ config, ... }: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:273, resizewindow"
      "$mod, mouse:272, movewindow"
    ];

    binde = [
      # binde repeats command while being held
      "$mod ALT, H, resizeactive, -10 0"
      "$mod ALT, J, resizeactive, 0 10"
      "$mod ALT, K, resizeactive, 0 -10"
      "$mod ALT, L, resizeactive, 10 0"
    ];

    bind =
      [
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$mod, W, exec, chromium"
        "$mod, Q, exec, kitty"

        "$mod, C, killactive"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, S, togglesplit"
        #"$mod, G, toggleopaque" DEP: Find replacement
        "$mod, G, togglegroup"
        "$mod, T, pin"

        "$mod CTRL, I, togglespecialworkspace, magic"
        "$mod CTRL SHIFT, I, movetoworkspace, special:magic"

        "$mod CTRL, O, togglespecialworkspace, hidden"
        "$mod CTRL SHIFT, O, movetoworkspace, special:hidden"

        "$mod CTRL, U, togglespecialworkspace, magicone"
        "$mod CTRL SHIFT, U, movetoworkspace, special:magicone"

        "$mod CTRL, P, togglespecialworkspace, hiddenone"
        "$mod CTRL SHIFT, P, movetoworkspace, special:hiddenone"

        ",Print, exec, hyprshot -m output -o /home/${config.variables.username}/Pictures/Screenshots"
        "CTRL, Print, exec, hyprshot -m region -o /home/${config.variables.username}/Pictures/Screenshots"

        "$mod CTRL SHIFT, M, exit"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
}
