# Imported into home manager
{ ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 16;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      wayland_titlebar_color = "system";
      #background_opacity = 0.5;
      sync_to_monitor = "yes";
      open_url_with = "chromium";
      disable_ligatures = "never";
    };
  };
}
