# Hyprland config for home-manager
{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        "DP-1, 1920x1080@60, 0x0, 1"
        "DP-2, 1920x1080@60, -1920x0, 1"
      ];

      bind =
        [
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"

          "$mod, F, exec, chromium"
          "$mod, Q, exec, kitty"
          "$mod, X, exec, exit"
	  "$mod CTRL, I, togglespecialworkspace, minimized"
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
  };
}
