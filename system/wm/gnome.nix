{
  self,
  nixpkgs,
  home-manager,
  ...
}: {
  options.services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

  };
}
