{
  headless,
  lib,
  ...
}:
{

  imports = [
    ./nix-pkgmgr
    ./hyprland
  ];

  config.hyprland-config.enable = lib.mkIf (!headless) true;

}
