# Python plugins for hyprland:
# Using pyprland for scratchpads
{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf config.hyprland-hm-config.enable {
    systemd.user.services.pyprland = {
      Unit = {
        Description = "Pyprland daemon";
        After = "graphical-session.target";
        Wants = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe' pkgs.pyprland "pypr"}";
        Restart = "always";
      };
    };
    home.packages = [ pkgs.pyprland ];

    home.file.".config/pypr/config.toml".text = ''
      [pyprland]
      plugins = [
        "scratchpads",
      ]

      [scratchpads.btop]
      animation = "fromTop"
      command = "${pkgs.kitty}/bin/kitty --class pyprland-btop -o font_size=12 btop"
      class = "pyprland-btop"
      lazy = false
      size = "75% 45%"

      [scratchpads.term]
      animation = "fromTop"
      command = "${pkgs.kitty}/bin/kitty --class pyprland-dropterm --hold fastfetch"
      class = "pyprland-dropterm"
      size = "75% 60%"

    '';

    wayland.windowManager.hyprland.settings = {
      bind = [
        "$mod ALT, I, exec, pypr toggle btop"
        "$mod ALT, O, exec, pypr toggle term"
      ];
      windowrule =
        let
          palette = config.colorScheme.palette;
          base08 = palette.base08; # Red
          base09 = palette.base09; # Orange
        in
        [
          "match:class ^(pyprland-btop)$, border_color rgb(${base08}) rgb(${base09}) 30deg, border_size 0"

          "match:class ^(pyprland-dropterm)$, border_color rgb(${base08}) rgb(${base09}) 30deg, border_size 0, dim_around on"
        ];
    };

  };
}
