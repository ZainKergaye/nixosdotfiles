{ config, ... }:
let
  palette = config.colorScheme.palette;
in
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;

        corner_radius = 10;
        progress_bar_corner_radius = 5;

        offset = "15x15";
        origin = "top-right";

        frame_color = "#${palette.base04}";

        font = "Hack Nerd Font Mono 10";

        browser = config.variables.default_browser;

        idle_threshold = "10m";
      };

      urgency_low = {
        background = "#${palette.base04}";
        foreground = "#${palette.base05}";
        frame_color = "#${palette.base0D}";
        timeout = 10;
      };

      urgency_normal = {
        background = "#${palette.base00}";
        foreground = "#${palette.base05}";
        frame_color = "#${palette.base04}";
        timeout = 10;
      };

      urgency_critical = {
        background = "#${palette.base0F}";
        foreground = "#${palette.base04}";
        frame_color = "#${palette.base09}";
        timeout = 10;
      };
    };
  };
}
