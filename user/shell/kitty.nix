# Imported into home manager
{ config, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 14;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      wayland_titlebar_color = "system";
      sync_to_monitor = "yes";
      open_url_with = config.variables.default_browser;
      disable_ligatures = "never";
      enable_audio_bell = "no";
    };
  };
}
