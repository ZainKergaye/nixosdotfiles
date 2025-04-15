{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    # TODO: Make custom script that seamlessly allows 0vol = mute and turning up vol unmutes
    binde = [
      # binde repeats command while being held
      ",XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ",XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%"
    ];

    bind = [
      ",XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ",XF86AudioMicMute, exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ];

    exec-once = [ "${pkgs.swayosd}" ];
  };

  home.packages = [ pkgs.swayosd ];

  services.swayosd = {
    enable = true;
    package = pkgs.swayosd;
    #display = "DP-1";
  };
}
