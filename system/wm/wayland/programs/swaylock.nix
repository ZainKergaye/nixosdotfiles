{ pkgs
, config
, ...
}:
let
  palette = config.colorScheme.palette;
in
{
  wayland.windowManager.hyprland.settings = {
    bindl = [
      # Laptop lid actions
      ", switch:24ffa00, exec, swaylock"
      ", switch:on:24ffa00, exec, swaylock" # NOTE: Test if doing anything
    ];
    bind = [ "$mod CTRL, L, exec, swaylock" ];
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock;
    settings = {
      font = "JetBrainsMono Nerd Font Mono";
      font-size = 15;

      line-uses-inside = true;

      disable-caps-lock-text = true;

      indicator-caps-lock = true;

      indicator-radius = 50;

      indicator-idle-visible = false;

      indicator-y-position = 540;

      show-failed-attempts = true;

      ignore-empty-password = true;
      indicator-thickness = 10;

      ring-color = "#${palette.base0B}";
      key-hl-color = "#${palette.base00}";

      color = "#000000";
      line-color = "#${palette.base0B}";
      inside-color = "#${palette.base01}";
      inside-clear-color = 00000088;
      separator-color = 00000000;
      ring-ver-color = "#${palette.base04}#";
      inside-ver-color = 00000000;
      text-color = "#${palette.base05}";
      bs-hl-color = "#${palette.base0F}";
      ring-clear-color = "#${palette.base0F}";
    };
  };
}
