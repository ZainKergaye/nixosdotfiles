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
            			# Intel FPGA Download Cable
            			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
            			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
            			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"

            			# Intel FPGA Download Cable II
            			# SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"

      						# STM32 discovery board
            			SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE:="0666", SYMLINK+="stlinkv2_%n"

      						# Apple
      						SUBSYSTEM=="usb", ATTR{idVendor}=="05ac", MODE="0666"

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
