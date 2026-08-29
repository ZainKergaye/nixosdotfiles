{ pkgs, lib, config, ... }:
{
  imports = [
    ./anyrun.nix
    ./idle.nix
    ./dunst.nix
    ./waybar.nix
    ./wlogout.nix
    ./pyprland.nix
    ./swayosd.nix
    ./hyprlock.nix
    ./wayscriber.nix
    #./waycorner.nix
  ];

  config = lib.mkIf config.hyprland-hm-config.enable {
  home.packages = with pkgs; [
    # Wallpaper
    waypaper-engine

    # Audio
    pwvucontrol

    # System info viewer
    hyprsysteminfo

    # Screenshot drawing tool
    swappy

    hyprpolkitagent # GUI auth
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now hyprpoltikagent.service"
  ];

  systemd.user.services.waypaper-daemon = {
    Unit = {
      Description = "Waypaper daemon";
      After = "graphical-session.target";
      Wants = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe' pkgs.waypaper-engine "waypaper-daemon"}";
      Restart = "always";
    };
  };
	};
}
