{ ... }: {
  networking.firewall = {
    enable = true;
    checkReversePath = false;
  };
  services.udev = {
    enable = true;
  };
}
