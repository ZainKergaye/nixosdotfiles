{
  pkgs,
  lib,
  ...
}:
let
  # Moves workspace 1-5 to monitor 1 when connecting to it
  handle_monitor_connect = lib.getExe (
    pkgs.writeShellScriptBin "handle_monitor_connect" ''
         handle() {
           case $1 in monitoradded*)
             hyprctl dispatch moveworkspacetomonitor "1 1"
             hyprctl dispatch moveworkspacetomonitor "2 1"
             hyprctl dispatch moveworkspacetomonitor "3 1"
             hyprctl dispatch moveworkspacetomonitor "4 1"
             hyprctl dispatch moveworkspacetomonitor "5 1"
           esac
         }

      ${pkgs.socat}/bin/socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
    ''
  );
in
{
  wayland.windowManager.hyprland.settings.exec-once = [ "${handle_monitor_connect}" ];
}
