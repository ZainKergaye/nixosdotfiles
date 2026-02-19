{ pkgs, ... }:
{
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
		pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.udev = {
    enable = true;
    #packages = [ pkgs.openocd ];
    extraRules = ''
			# Intel FPGA Download Cable
			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"

			# Intel FPGA Download Cable II
			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"

			SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE:="0666", SYMLINK+="stlinkv2_%n"
    '';
  };
}
