# Python plugins for hyprland:
# Using pyprland for scratchpads
{
  lib,
  pkgs,
  ...
}:
{
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
    command = "${pkgs.kitty}/bin/kitty --class kitty-btop -o font_size=12 btop"
    class = "kitty-btop"
    lazy = false
    size = "75% 45%"

    [scratchpads.term]
    animation = "fromTop"
    command = "${pkgs.kitty}/bin/kitty --class kitty-dropterm --hold fastfetch"
    class = "kitty-dropterm"
    size = "75% 60%"

  '';

  wayland.windowManager.hyprland.settings.bind = [
    "$mod ALT, I, exec, pypr toggle btop"
    "$mod ALT, O, exec, pypr toggle term"
  ];
}
