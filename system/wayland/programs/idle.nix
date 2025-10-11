# Imported into home-manager, this is swayidle that does 4 things:
# 1. Turns off the screen at 4.5 mins
# 2. Locks the screen at 5 mins
{
  pkgs,
  lib,
  ...
}:
let
  exec-hyprlock-once = lib.getExe (
    pkgs.writeShellScriptBin "exec-hyprlock-once" ''
         if (pgrep -x hyprlock > /dev/null); then
           ${pkgs.dunst}/bin/dunstify -u low -a swayidle "Tried locking screen, already locked"
      else
           ${pkgs.hyprland}/bin/hyprctl dispatch exec ${pkgs.hyprlock}/bin/hyprlock
         fi
    ''
  );
  hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
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
        command = "${hyprctl} dispatch dpms off";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }
      {
        # Lock screen
        timeout = 60 * 5; # 5 mins
        command = "${exec-hyprlock-once}";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }
      {
        # Hibernate
        timeout = 60 * 60 * 5; # 5 hours
        command = "systemctl hybrid-sleep";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${exec-hyprlock-once}";
      }
    ];
  };
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "sway-audio-idle-inhibit" ];
}
