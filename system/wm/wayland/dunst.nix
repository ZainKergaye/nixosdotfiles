{...}: {
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
	frame_color="#eceff1";
	font = "JetBrainsMono Nerd Font Mono 10";
      };
      urgency_normal = {
	background = "#37474f";
	foreground = "#eceff1";
	timeout = 10;
      };
    };
  };
}
