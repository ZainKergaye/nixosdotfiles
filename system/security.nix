{ pkgs, ... }:
{
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  networking.firewall = rec {
    enable = true;
    checkReversePath = false;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  services.usbmuxd.enable = true;

  services.udev = {
    enable = true;
    #packages = [ pkgs.openocd ];
    extraRules = ''
			# Apple
			SUBSYSTEM=="usb", ATTR{idVendor}=="05ac", MODE="0666"
			SUBSYSTEM=="usb", \
				ATTRS{idVendor}=="2e8a", \
				ATTRS{idProduct}=="0003", \
				MODE="660", \
				GROUP="plugdev"
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="0009", \
					MODE="660", \
					GROUP="plugdev"
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="000a", \
					MODE="660", \
					GROUP="plugdev"
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="000f", \
					MODE="660", \
					GROUP="plugdev"

			# Rules for seat access
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="0003", \
					TAG+="uaccess"
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="0009", \
					TAG+="uaccess"
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="000a", \
					TAG+="uaccess"
			SUBSYSTEM=="usb", \
					ATTRS{idVendor}=="2e8a", \
					ATTRS{idProduct}=="000f", \
					TAG+="uaccess"
    '';
  };

  # Using https://github.com/viktor-grunwaldt/t480-fingerprint-nixos
  services."06cb-009a-fingerprint-sensor" = {
    enable = true;
    backend = "libfprint-tod";
    calib-data-file = ../media/calib-data.bin;
  };
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
  };
  security.pam.services.hyprlock = { };
}
