{ pkgs, ... }: {
  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.udev = {
    enable = true;
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

  security.pam.services.hyprlock = { };
  security.pam.services.hyprlock.fprintAuth = true;
}
