# Python plugins for hyprland:
# Using pyprland for scratchpads
{ pkgs, ... }: {
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

    [scratchpads.todo]
    animation = "fromLeft"
    command = "${pkgs.kitty}/bin/kitty --class nvim --hold nvim /home/aegis/Downloads/TODO.md"
    class = "nvim"
    lazy = false
    size = "45% 75%"

    [scratchpads.term]
    animation = "fromTop"
    command = "${pkgs.kitty}/bin/kitty --class kitty-dropterm --hold neofetch"
    class = "kitty-dropterm"
    size = "75% 60%"

    [scratchpads.termtwo]
    animation = "fromLeft"
    command = "${pkgs.kitty}/bin/kitty --class term --hold neofetch"
    class = "term"
    lazy = true
    size = "40% 90%"
  '';

  wayland.windowManager.hyprland.settings.bind = [
    "$mod ALT, I, exec, pypr toggle btop"
    "$mod ALT, U, exec, pypr toggle todo"
    "$mod ALT, O, exec, pypr toggle term"
    "$mod ALT, P, exec, pypr toggle termtwo"
  ];
}
