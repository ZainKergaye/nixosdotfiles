# Imported into home-manager, this is swayidle that does 4 things:
# 1. Turns off the screen at 4.5 mins
# 2. Locks the screen at 5 mins
# 3. Sleeps the pc at 30 mins
# 4. Hibernates the computer at 2 hours
{ pkgs
, config
, lib
, ...
}:
let
  # Simple script to suspend / hibernate pc. This is just to
  # debug my normal commands not working
  systemctl-suspend-hibernate = lib.getExe (pkgs.writeShellScriptBin "systemctl-suspend-hibernate" ''
    if ["$1" == 0 ]; then
      systemctl hibernate
    else
      systemctl suspend
    fi
  '');
in
{
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "hyprland-session.target";

    timeouts = [
      {
        # Sleep screen
        timeout = 30 * 9; # 4.5 mins
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
      {
        # Lock screen
        timeout = 60 * 5; # 5 mins
        command = "${pkgs.swaylock}/bin/swaylock";
        resumeCommand = "${pkgs.dunst}/bin/dunstify UNLOCKED";
      }
      {
        #                  WARN: Not tested yet
        # Sleep computer
        timeout = 60 * 30; # 30 mins
        command = "${systemctl-suspend-hibernate}";
        resumeCommand = "${pkgs.dunst}/bin/dunstify resumed";
      }
      {
        # Hibernate computer
        timeout = 60 * 120; # 2 Hours
        command = "${systemctl-suspend-hibernate} 0"; # Runs the command but does not hibernate
        resumeCommand = "${pkgs.dunst}/bin/dunstify resumedHibernation";
      }
    ];
  };
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "exec sway-audio-idle-inhibit" ];
}
