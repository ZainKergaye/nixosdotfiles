# System module for Plasma 5 desktop. Imported in configuration.nix
{pkgs, ...}: {
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;

    videoDrivers = ["xf86-video-intel"];

    xkb.layout = "us";
    xkb.variant = "";
  };

  services.displayManager.sddm.enable = true;

  services.libinput.enable = true; # touchpad
  services.libinput.touchpad.naturalScrolling = true;

  programs.light.enable = true;

  boot.kernelParams = ["nomodeset"]; # Hyper-V support

  environment.systemPackages = [pkgs.kdePackages.powerdevil];
}
