# Imported into home-manager, this is swayidle that does 4 things:
# 1. Turns off the screen at 4.5 mins
# 2. Locks the screen at 5 mins
{ pkgs
, lib
, ...
}:
let
  exec-swaylock-once = lib.getExe (pkgs.writeShellScriptBin "exec-swaylock-once" ''
       if (pgrep -x swaylock > /dev/null); then
         ${pkgs.dunst}/bin/dunstify -u low -a swayidle "Tried locking screen, already locked"
    else
         ${pkgs.hyprland}/bin/hyprctl dispatch exec ${pkgs.swaylock-effects}/bin/swaylock
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
        command = "${exec-swaylock-once}";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${exec-swaylock-once}";
      }
    ];
  };
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "sway-audio-idle-inhibit" ];
}
