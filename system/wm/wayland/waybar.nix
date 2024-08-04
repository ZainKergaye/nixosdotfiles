{config, ...}: {
  programs.waybar = {
    enable = true;
  };
	home.file."${config.xdg.configHome}/waybar/style.css" = {
		#source = ["./style.css" "./config.jsonc"];
		#source = "./style.css";
		text = builtins.readFile(./style.css);
	};

	home.file."${config.xdg.configHome}/waybar/config.jsonc" = {
		text = builtins.readFile(./config.jsonc);
	};
}
