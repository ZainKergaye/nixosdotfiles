{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.hyprland-hm-config.enable {

    wayland.windowManager.hyprland.settings.monitor = [
      "ipad, 1920x1440@60, auto-left, 1.25"
    ];

    #home.packages = [ pkgs.weylus];

    # wayland.windowManager.hyprland.settings.bind = [
    #   "$mod, P, exec, pkill -SIGUSR1 wayscriber"
    # ];
    #
    # systemd.user.services.wayscriber = {
    #   Unit.Description = "OSD Drawing tool";
    #   Install.WantedBy = [ "default.target" ];
    #   Service.ExecStart = "${lib.getExe' pkgs.wayscriber "wayscriber"} --daemon";
    # };
  };
}
