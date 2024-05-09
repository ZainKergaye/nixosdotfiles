{config, system, self, pkgs, ...}:

{
services.xserver = {
	enable = true;
	displayManager.sddm.enable = true;
	desktopManager.plasma5.enable = true;

    	layout = "us";
    	xkbVariant = "";
};

boot.loader.kernelParams = ["nomodeset"]; # Hyper-V support
}
