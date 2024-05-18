# Hyprland config for home-manager
{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        ", preferred, auto, 1"
        "DP-2, 1920x1080@60, -1920x0, 1"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
	"col.active_border, rgba(33ccffee) rgba(00ff99ee) 45deg"
	"col.inactive_border, rgba(595959aa)"
	"col.shadow, rgba(1a1a1aee)"
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
      };

      bind =
        [
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"

          "$mod, F, exec, chromium"
          "$mod, Q, exec, kitty"
          "$mod, X, exec, exit" # REDO THIS
          "$mod CTRL, I, togglespecialworkspace, minimized" # Move to special workspace kbnd?
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
