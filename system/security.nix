{ config
, pkgs
, ...
}: {
  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.udev = {
    enable = true; # NOTE: Delete after classes done
    extraRules = ''
      # Intel FPGA Download Cable
      SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6001", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6002", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6003", MODE="0666"

      # Intel FPGA Download Cable II

      SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6010", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="09fb", ATTR{idProduct}=="6810", MODE="0666"
    '';
  };

  # services."06cb-009a-fingerprint-sensor" = {
  #   enable = true;
  #   backend = "libfprint-tod";
  #   calib-data-file = ./calib-data.bin;
  # };

  services.fprintd = {
    enable = true;
    #package = pkgs.fprintd-tod;
  };

  security.pam.services.swaylock = { }; # TODO: Not working still
  security.pam.services.swaylock.fprintAuth = true;
}
