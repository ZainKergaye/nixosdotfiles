{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.hyprland-hm-config.enable {
    systemd.user.services.swayosd-server = {
      Unit = {
        Description = "swayosd-server";
        After = "graphical-session.target";
        Wants = "graphical-session.target";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe' pkgs.swayosd "swayosd-server"}";
        Restart = "always";
      };
    };

    wayland.windowManager.hyprland.settings.bind =
      let
        inherit (import ../lua.nix { inherit lib; }) bind bindRepeat exec;
        swayosd = lib.getExe' pkgs.swayosd "swayosd-client";
        focused-monitor = ''--monitor "$(${lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl"} monitors -j | ${lib.getExe' pkgs.jq "jq"} -r '.[] | select(.focused == true).name')"'';
        command = args: exec "${swayosd} ${focused-monitor} ${args}";
      in
      [
        (bindRepeat "XF86AudioLowerVolume" (command "--output-volume lower"))
        (bindRepeat "XF86AudioRaiseVolume" (command "--output-volume raise"))
        (bindRepeat "XF86MonBrightnessUp" (command "--brightness raise"))
        (bindRepeat "XF86MonBrightnessDown" (command "--brightness lower"))
        (bind "XF86AudioMute" (command "--output-volume mute-toggle"))
        (bind "XF86AudioMicMute" (command "--input-volume mute-toggle"))
      ];
  };

  # udev and systemd config in ../hypr
}
