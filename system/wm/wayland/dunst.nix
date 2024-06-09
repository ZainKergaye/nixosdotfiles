{config, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        corner_radius = 10;
        offset = "15x15";
        origin = "top-right";
        transparancy = 10;
        frame_color = "#${config.colorScheme.colors.base04}";
        font = "Hack Nerd Font Mono 10";
      };
      urgency_normal = {
        background = "#${config.colorScheme.colors.base00}";
        foreground = "#${config.colorScheme.colors.base05}";
        timeout = 10;
      };
    };
  };
}
