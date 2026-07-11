{ pkgs, ... }:
{

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    enableSSHSupport = true;
  };

  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };

  services.udev = {
    enable = true;
  };
}
