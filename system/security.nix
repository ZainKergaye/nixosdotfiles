{ config
, pkgs
, ...
}: {
  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.udev = {
    enable = true;
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

  services."06cb-009a-fingerprint-sensor" = {
    enable = true;
    backend = "libfprint-tod";
    #calib-data-file = ./calib-data.bin;
  };

  services.fprintd = {
    enable = true;
    #package = pkgs.fprintd-tod;
  };

  security.pam.services.swaylock = { }; # TODO: Not working still
  security.pam.services.swaylock.fprintAuth = true;

  # Pulled from https://github.com/NixOS/nixpkgs/issues/143365#issuecomment-1293871094
  security.pam.services.swaylock.text = ''
    # Account management.
    account required pam_unix.so

    # Authentication management.
    auth sufficient pam_unix.so   likeauth try_first_pass
    auth required pam_deny.so

    # Password management.
    password sufficient pam_unix.so nullok sha512

    # Session management.
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';
}
