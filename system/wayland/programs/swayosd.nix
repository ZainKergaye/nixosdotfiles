{ pkgs
, lib
, ...
}: {
  wayland.windowManager.hyprland.settings =
    let
      swayosd = lib.getExe' pkgs.swayosd "swayosd-client";
      focused-monitor = ''--monitor "$(${lib.getExe' pkgs.hyprland "hyprctl"} monitors -j | ${lib.getExe' pkgs.jq "jq"} -r '.[] | select(.focused == true).name')"'';
    in
    {
      exec-once = [ "${lib.getExe' pkgs.swayosd "swayosd-server"}" ];

      binde = [
        # binde repeats command while being held
        ",XF86AudioLowerVolume, exec, ${swayosd} ${focused-monitor} --output-volume lower"
        ",XF86AudioRaiseVolume, exec, ${swayosd} ${focused-monitor} --output-volume raise"

        ",XF86MonBrightnessUp, exec, ${swayosd} ${focused-monitor} --brightness raise"
        ",XF86MonBrightnessDown, exec, ${swayosd} ${focused-monitor} --brightness lower"
      ];

      bind = [
        ",XF86AudioMute, exec, ${swayosd} ${focused-monitor} --output-volume mute-toggle"
        ",XF86AudioMicMute, exec, ${swayosd} ${focused-monitor} --input-volume mute-toggle"
      ];
    };

  # udev and systemd config in ../hypr
}
