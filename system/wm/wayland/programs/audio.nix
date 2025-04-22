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

    # exec-once = [ "${pkgs.swayosd}/bin/swayosd-server" ];
  };

  # home.packages = [ pkgs.swayosd ];

  # TODO: Later
  # systemd.user.services.swayosd-libinput-backend = {
  #   unitConfig = {
  #     Description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc...";
  #     Documentation = [ "https://github.com/ErikReider/SwayOSD" ];
  #     PartOf = [ "graphical.target" ];
  #     After = [ "graphical.target" ];
  #   };
  #
  #   serviceConfig = {
  #     Type = "dbus";
  #     BusName = "org.erikreider.swayosd";
  #     ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
  #     Restart = "on-failure";
  #   };
  #
  #   wantedBy = [ "graphical.target" ];
  # };
  #
  # # udev rule in ../hypr
  # NOTE: Don't forget to enable

  # Do everything manually here instead of it auto configured by nix.
  # Get bootloader to still be able to select gens
}
