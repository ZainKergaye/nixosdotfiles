{ lib, config, ... }:
{
  config = lib.mkIf config.hyprland-hm-config.enable {
    wayland.windowManager.hyprland.settings = {
      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      binde = [
        # binde repeats command while being held
        "SUPER ALT, H, resizeactive, -10 0"
        "SUPER ALT, J, resizeactive, 0 10"
        "SUPER ALT, K, resizeactive, 0 -10"
        "SUPER ALT, L, resizeactive, 10 0"
      ];

      bind = [
        ", mouse:275, workspace, m-1"
        ", mouse:276, workspace, m+1"

        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"

        "SUPER, W, exec, chromium"
        "SUPER, Q, exec, kitty"

        "SUPER, C, killactive"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen"
        #"SUPER, S, togglesplit"
        "SUPER, T, pin"

        "SUPER CTRL, 1, tagwindow, op100"
        "SUPER CTRL, 2, tagwindow, op80"
        "SUPER CTRL, 3, tagwindow, op60"

        "SUPER CTRL, I, togglespecialworkspace, magic"
        "SUPER CTRL SHIFT, I, movetoworkspace, special:magic"

        "SUPER CTRL, O, togglespecialworkspace, hidden"
        "SUPER CTRL SHIFT, O, movetoworkspace, special:hidden"

        "SUPER CTRL, U, togglespecialworkspace, magicone"
        "SUPER CTRL SHIFT, U, movetoworkspace, special:magicone"

        "SUPER CTRL, P, togglespecialworkspace, hiddenone"
        "SUPER CTRL SHIFT, P, movetoworkspace, special:hiddenone"

        ",Print, exec, hyprshot -m output -o /home/${config.variables.username}/Pictures/Screenshots"
        "CTRL, Print, exec, hyprshot -m region -o /home/${config.variables.username}/Pictures/Screenshots"

        "SUPER CTRL SHIFT, M, exit"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "SUPER, ${ws}, workspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10
        )
      );
    };
  };
}
