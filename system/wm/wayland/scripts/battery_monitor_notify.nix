# Imported into home manager
# Used to monitor the percentage of BAT1 and send a notification using dunst
# Sends notification at 10% battery.
{ pkgs
, lib
, ...
}:
let
  battery_monitor_notify = lib.getExe (pkgs.writeShellScriptBin "battery_monitor_notify" ''

     # Function to check battery percentage
     get_battery_percentage() {
		 local capacity_file="/sys/class/power_supply/BAT1/capacity"
		
			if [[ -f "$capacity_file" ]]; then
				cat "$capacity_file"
			else
				echo "ERR"
			fi
     }

     # Main loop
     while true; do
         percentage=$(get_battery_percentage)

         # Check if we were able to get a valid battery percentage
         if [[ "$percentage" == "ERR" ]]; then
             ${pkgs.dunst}/bin/dunstify -u low -a battery_monitor "Cannot read battery info"
             sleep 1m
             continue
         fi

         # Check if the battery level is at or below 10%
         if (( percentage <= 10 )); then
             ${pkgs.dunst}/bin/dunstify -u critical -a battery_monitor "Low battery"
         fi

         # Sleep for a minute before checking again
         sleep 1m
     done
  '');
in
{
  wayland.windowManager.hyprland.settings.exec-once = [ "${battery_monitor_notify}" ];
}
