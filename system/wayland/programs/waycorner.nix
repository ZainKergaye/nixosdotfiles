# home-manager
{
  pkgs,
  config,
  lib,
  ...
}:
{

  home.packages = [
    pkgs.waycorner
  ];

  systemd.user.services.waycorner = {
    Unit = {
      Description = "waycorner";
      After = "graphical-session.target";
      Wants = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe' pkgs.waycorner "waycorner"}";
      Restart = "always";
    };
  };

  home.file."${config.xdg.configHome}/waycorner/config.toml".text = ''
    		[main-monitor]
    		# Shell commands to execute when hotcorner is triggered,
    		# at least one is required.

    		# Command to run when cursor enters hotcorner.
    		# `command` is an alias for `enter_command`.
    		enter_command = ["sh", "-c", "kill -s USR1 $(pidof waybar)"]
    		exit_command  = ["sh", "-c", "kill -s USR2 $(pidof waybar)"]

    		# Locations of the hot corners.
    		# Options:
    		# - for corners: top_left, top_right, bottom_right, and bottom_left;
    		# - for edges: top, bottom, right, left.
    		locations = ["top"]

    		# Size of the hot corners in pixels, for edges the size means the width
    		# for vertical edges, and height for horizontal edges. The other dimension
    		# will be the width/height of your display - the set margin.
    		size = 13  # default

    		# Margin on the sides of the hot edges, only applicable to edge locations.
    		# See the comment with sizes attribute above.
    		margin = 20  # default

    		timeout_ms = 125

    		# Hex color of the corner when previewed, supports transparency. (#AARRGGBB or #RRGGBB)
    		# (Useful for debugging purposes when setting up several hot corners.)
    		color = "#FFFF0000"  # default

    		# Optional output config to specify what output to use.
    		[main-monitor.output]
    		# Regex to match output descriptions on.
    		# Regex engine is similar to RE2: https://github.com/rust-lang/regex
    		#
    		# Use `swaymsg -t get_outputs` to get a list of outputs in the format:
    		# Output $NAME} '$DESCRIPTION}'
    		# Use `swaymsg -t get_outputs` or `hyprctl monitors` to list your outputs.
    		# The description of the output is what is matched.
    		# This often contains the output name, manufacturer, model, and serial number so
    		# any of those could be used for matching.
    		description = ""  # default, empty means all outputs

    		# [side-monitor]
    		# enter_command = [ "notify-send", "left" ]
    		# locations = ["right"]
    		#
    		# [side-monitor.output]
    		# description = "U2515H 9X2VY6A80A8L"
  '';

}
