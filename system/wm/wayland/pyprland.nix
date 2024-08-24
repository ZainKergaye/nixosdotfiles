# Python plugins for hyprland: 
# Using pyprland for scratchpads 
{
  pkgs,
  ...
}: {

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

    [scratchpads.chrome]
    animation = "fromBottom"
    command = "chromium"
    class = "chrome"
    lazy = true
    size = "75% 40%"

    [scratchpads.term]
    animation = "fromTop"
    command = "${pkgs.kitty}/bin/kitty --class kitty-dropterm --hold neofetch"
    class = "kitty-dropterm"
    size = "75% 60%"

    [scratchpads.volume]
    animation = "fromRight"
    command = "${pkgs.pwvucontrol}/bin/pwvucontrol"
    class = "org.pulseaudio.pwvucontrol"
    lazy = true
    size = "40% 90%"
    unfocus = "hide"
  '';

  wayland.windowManager.hyprland.settings.bind = [
    "$mod ALT, I, exec, pypr toggle btop"
    "$mod ALT, U, exec, pypr toggle chrome"
    "$mod ALT, O, exec, pypr toggle term"
    "$mod ALT, P, exec, pypr toggle volume"
  ];
}
