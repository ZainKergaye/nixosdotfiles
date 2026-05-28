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
           ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
         fi
    ''
  );
  brightnessctl = lib.getExe' pkgs.brightnessctl "brightnessctl";
  toggle-dim = lib.getExe (
    pkgs.writeShellScriptBin "toggle-dim" ''
      STATE_FILE="/tmp/brightnessctl-saved"

      if [[ "$1" == "reset" || "$1" == "--reset" ]]; then
        # Restore saved brightness if file exists
        if [[ -f "$STATE_FILE" ]]; then
          VALUE=$(cat "$STATE_FILE")
          ${brightnessctl} set "$VALUE"
          rm -f "$STATE_FILE"
        else
          ${pkgs.libnotify}/bin/notify-send --urgency=critical --hint=int:transient:1 "Error" "state file not found"
          exit 1
        fi
      else
        # Save current brightness to file if not already saved
        if [[ ! -f "$STATE_FILE" ]]; then
          CURRENT=$(${brightnessctl} g)
          echo "$CURRENT" > "$STATE_FILE"
        fi
        ${brightnessctl} set "${"$"}{1:-10%}"
      fi
    ''
  );
  hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
in
{
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTargets = [ "hyprland-session.target" ];

    timeouts = [
      {
        # Sleep screen
        timeout = 30 * 9; # 4.5 mins
        command = "${toggle-dim}";
        resumeCommand = "${toggle-dim} --reset";
      }
      {
        # Lock screen
        timeout = 60 * 7; # 7 mins
        command = "${exec-hyprlock-once}";
        resumeCommand = "${hyprctl} dispatch dpms on; ${toggle-dim} --reset";
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
      {
        event = "unlock";
        command = "${toggle-dim} --reset";
      }
    ];
  };
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
  ];

  systemd.user.services.sway-audio-idle-inhibit = {
    Unit = {
      Description = "sway-audio-idle-inhibit";
      After = "graphical-session.target";
      Wants = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe' pkgs.sway-audio-idle-inhibit "sway-audio-idle-inhibit"}";
      Restart = "always";
    };
  };
}
