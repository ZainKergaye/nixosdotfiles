# Hyprland config for home-manager
{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, chromium"
        "$mod, Q, exec, kitty"
        "$mod, M, exit"
      ];
    };
  };
}
