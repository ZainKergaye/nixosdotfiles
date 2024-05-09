# System module for Plasma 5 desktop. Imported in configuration.nix

{config, system, self, pkgs, ...}:

{
services.xserver = {
	enable = true;
	displayManager.sddm.enable = true;
	desktopManager.plasma5.enable = true;

	libinput.enable = true; # touchpad

    	layout = "us";
    	xkbVariant = "";
};

boot.kernelParams = ["nomodeset"]; # Hyper-V support
}
