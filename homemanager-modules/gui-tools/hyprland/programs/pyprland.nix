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
      bind =
        let
          inherit (import ../lua.nix { inherit lib; }) modBind exec;
        in
        [
          (modBind "ALT + I" (exec "pypr toggle btop"))
          (modBind "ALT + O" (exec "pypr toggle term"))
        ];
      window_rule =
        let
          palette = config.colorScheme.palette;
        in
        [
          {
            match.class = "^(pyprland-btop)$";
            border_color = "rgb(${palette.base08}) rgb(${palette.base09}) 30deg";
            border_size = 0;
          }
          {
            match.class = "^(pyprland-dropterm)$";
            border_color = "rgb(${palette.base08}) rgb(${palette.base09}) 30deg";
            border_size = 0;
            dim_around = true;
          }
        ];
    };
  };
}
