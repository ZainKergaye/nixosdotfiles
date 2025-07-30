{ pkgs
, config
, lib
, ...
}: {
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
        font = "IBM Plex Mono";
      in
      {
        general = {
          grace = 60;
          hide_cursor = true;
        };

        auth = {
          fingerprint.enabled = true;
        };

        background = [
          {
            color = "rgb(${palette.base00})";
            blur_passes = 0;
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "300, 60";
            outline_thickness = 4;
            dots_size = 0.2;
            dots_spacing = 0.2;
            dots_center = true;
            outer_color = "rgb(${palette.base05})";
            inner_color = "rgb(${palette.base04})";
            font_color = "rgb(${palette.base03})";
            fade_on_empty = false;
            placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
            hide_input = false;
            check_color = "rgb(${palette.base01})";
            fail_color = "rgb(${palette.base08})";
            fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
            capslock_color = "rgb(${palette.base0A})";
            position = "0, -47";
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
            font_size = 90;
            font_family = font;
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }
          {
            # Date
            monitor = "";
            text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
            color = "rgb(${palette.base03}";
            font_size = 25;
            font_family = font;
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];
      };
  };
}
