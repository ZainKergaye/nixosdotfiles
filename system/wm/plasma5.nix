# System module for Plasma 5 desktop. Imported in configuration.nix

{config, system, self, pkgs, ...}:

{
services.xserver = {
	enable = true;
	desktopManager.plasma5.enable = true;


    	xkb.layout = "us";
    	xkb.variant = "";
};

services.displayManager.sddm.enable = true;

services.libinput.enable = true; # touchpad

boot.kernelParams = ["nomodeset"]; # Hyper-V support
}
