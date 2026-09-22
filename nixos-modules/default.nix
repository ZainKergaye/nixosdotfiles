{
  headless,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./nix-pkgmgr
    ./hyprland
  ];

  config.hyprland-config.enable = lib.mkIf (!headless) true;

  config.environment.systemPackages = with pkgs; [
    usbutils
  ];
}
