# Imported into hyprland.nix - which is imported into home-manager
{ ... }: 
{

  wayland.windowManager.hyprland.settings = {
		bind = [
		"$mod, ., submap, submap1"
		", escape, submap, submap1"
		];

		submap = "submap1";
		binde = [
			"H, resizeactive, -10 0"
			"L, resizeactive, 10 0"
			"K, resizeactive, 0 -10"
			"J, resizeactive, 0 10"

		];
		submap = "reset";
		# Need submap commands to be like this
	
  };
}
