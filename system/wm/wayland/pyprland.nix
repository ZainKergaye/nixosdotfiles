{
  pkgs,
  config,
  ...
}: {
  home.file."${config.xdg.configHome}/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.btop]
    animation = "fromBottom"
    command = "${pkgs.kitty}/bin/kitty --class kitty-btop btop"
    class = "kitty-btop"
    lazy = true
    size = "75% 45%"

    [scratchpads.chrome]
    animation = "fromTop"
    command = "${pkgs.kitty}/bin/kitty --class chrome chromium"
    class = "kitty-chrome"
    lazy = true
    size = "75% 40%"

    [scratchpads.term]
    animation = "fromTop"
    command = "${pkgs.kitty}/bin/kitty --class kitty-dropterm"
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
    "$mod, ALT, I, exec, pypr toggle btop"
    "$mod, ALT, U, exec, pypr toggle chrome"
    "$mod, ALT, O, exec, pypr toggle term"
    "$mod, ALT, P, exec, pypr toggle volume"
  ];
}
