# Imported into home-manager, this is swayidle that does 4 things:
# 1. Turns off the screen at 4.5 mins
# 2. Locks the screen at 5 mins
# 3. Sleeps the pc at 30 mins
# 4. Hibernates the computer at 2 hours
{ pkgs
, lib
, ...
}:
let
  systemctl-suspend = lib.getExe (pkgs.writeShellScriptBin "systemctl-suspend" " systemctl suspend ");
  systemctl-hibernate = lib.getExe (pkgs.writeShellScriptBin "systemctl-hibernate" " systemctl hibernate ");
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
        command = "${pkgs.swaylock-effects}/bin/swaylock";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
      {
        # BUG: Not working
        # Hibernate computer
        timeout = 60 * 120; # 2 Hours
        command = "systemctl suspend-then-hibernate";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock";
      }
    ];
  };
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "sway-audio-idle-inhibit" ];
}
