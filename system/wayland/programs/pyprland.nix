# Python plugins for hyprland:
# Using pyprland for scratchpads
{
  config,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings.exec-once = [ "${pkgs.pyprland}/bin/pypr" ];

  home.packages = [ pkgs.pyprland ];

  home.file.".config/hypr/pyprland.toml".text = ''
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
