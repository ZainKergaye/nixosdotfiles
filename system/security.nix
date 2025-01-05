{ ... }: {
  networking.firewall = {
    enable = true;
  };
  services.udev = {
    enable = true;
  };
}
