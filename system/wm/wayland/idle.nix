{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    systemdTarget = "hyprland-session.target";

    timeouts = [
      {
        # Lock screen
        timeout = 60 * 5; # 5 mins
        command = "${pkgs.swaylock}/bin/swaylock";
        resumeCommand = "${pkgs.dunst}/bin/dunstify UNLOCKED";
      }
      {
        # Sleep
        timeout = 60 * 30; # 30 mins
        command = "systemctl suspend";
        resumeCommand = "${pkgs.dunst}/bin/dunstify resumed";
      }
      {
        # Hibernate
        timeout = 60 * 120; # 2 Hours
        command = "systemctl hibernate";
        resumeCommand = "${pkgs.dunst}/bin/dunstify resumedHibernation";
      }
    ];
  };
  home.packages = with pkgs; [
    swayidle
  ];
}
