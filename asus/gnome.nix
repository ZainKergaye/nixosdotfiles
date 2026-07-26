{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.gnomeExtensions.appindicator ];

  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
    xserver.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
