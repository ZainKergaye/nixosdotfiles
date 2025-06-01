{ pkgs, ... }: {
  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.udev = {
    enable = true;
    extraRules = ''
      SUBSYSTEM=="tty", GROUP="dialout". MODE="0660"
         SUBSYSTEMS=="usb", ATTRS{idProduct}=="7523", ATTRS{idVendor}=="1a86", SYMLINK+="arduino"
    '';
  };

  services."06cb-009a-fingerprint-sensor" = {
    enable = true;
    backend = "libfprint-tod";
    calib-data-file = ../media/calib-data.bin;
  };

  # Using: https://github.com/viktor-grunwaldt/t480-fingerprint-nixos
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
  };

  security.pam.services.swaylock = { }; # TODO: Not working still
  security.pam.services.swaylock.fprintAuth = true;
}
