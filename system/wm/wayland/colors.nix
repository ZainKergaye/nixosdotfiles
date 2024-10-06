{ lib
, config
, ...
}:
let
  palette = config.colorScheme.palette;
  base00 = palette.base00; # Background
  base01 = palette.base01; # Lighter background
  base02 = palette.base02; # Selection background
  base03 = palette.base03; # Comments
  base04 = palette.base04; # Dark foreground
  base05 = palette.base05; # Default foreground
  base06 = palette.base06; # Light foreground
  base07 = palette.base07; # The lightest foreground
  base08 = palette.base08; # Red
  base09 = palette.base09; # Orange
  base0A = palette.base0A; # Yellow
  base0B = palette.base0B; # Green
  base0C = palette.base0C; # Cyan
  base0D = palette.base0D; # Blue
  base0E = palette.base0E; # Purple
  base0F = palette.base0F; # Dark red
in
{
  wayland.windowManager.hyprland = {
    enable = lib.mkDefault false;
    settings = {
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      general = {
        "col.active_border" = "rgb(${base07}) rgb(${base0B}) 45deg";
        # "col.active_border" = "rgb(${base07})";
        "col.inactive_border" = "rgb(${base04})";
      };
      group = {
        "col.border_active" = "rgb(${base02})";
        "col.border_inactive" = "rgb(${base04})";
        groupbar = {
          "col.active" = "rgb(${base02})";
          "col.inactive" = "rgb(${base04})";

          font_family = "IBM Plex Mono";
          render_titles = false;
        };
      };
    };
  };
}
