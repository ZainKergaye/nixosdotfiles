{ pkgs, lib, ... }:
{

  home.packages = [ pkgs.wayscriber ];

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, P, exec, pkill -SIGUSR1 wayscriber"
  ];

  systemd.user.services.wayscriber = {
    Unit.Description = "OSD Drawing tool";
    Install.WantedBy = [ "default.target" ];
    Service.ExecStart = "${lib.getExe' pkgs.wayscriber "wayscriber"} --daemon";
  };
}
