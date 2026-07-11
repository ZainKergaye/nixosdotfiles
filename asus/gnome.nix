{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.gnomeExtensions.appindicator ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
    desktopManager.gnome.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
}
