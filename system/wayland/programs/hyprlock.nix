{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings =
    let
      hyprlock-bin = lib.getExe' pkgs.hyprlock "hyprlock";
    in
    {
      bindl = [
        # Laptop lid actions
        ", switch:24ffa00, exec, ${hyprlock-bin}"
        ", switch:on:24ffa00, exec, ${hyprlock-bin}"
      ];
      bind = [ "$mod CTRL, L, exec, ${hyprlock-bin}" ];
    };

  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings =
      let
        palette = config.colorScheme.palette;
        font = "jetBrainsMono Nerd Font Propo";
      in
      {
        general = {
          grace = 60;
          hide_cursor = false;
          ignore_empty_input = true;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 1;
            blur_size = 5;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "300, 50";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.2;
            dots_center = true;
            outer_color = "rgb(${palette.base05})";
            inner_color = "rgb(${palette.base04})";
            font_color = "rgb(${palette.base03})";
            fade_on_empty = false;
            placeholder_text = ''<span foreground="##cad3f5"> </span>'';
            hide_input = false;
            check_color = "rgb(${palette.base01})";
            fail_color = "rgb(${palette.base08})";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            position = "0, -260";
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          {
            # Time
            monitor = "";
            text = "$TIME12";
            color = "rgb(${palette.base03}";
            font_size = 120;
            font_family = font;
            position = "0, -200";
            halign = "center";
            valign = "top";
          }
          {
            # Date
            monitor = "";
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = "rgb(${palette.base03}";
            font_size = 25;
            font_family = font;
            position = "0, -200";
            halign = "center";
            valign = "top";
          }
        ];

      };
  };
}
