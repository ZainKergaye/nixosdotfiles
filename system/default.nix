{ ... }:
{
  imports = [
    ./wayland/hypr.nix
    ./fonts.nix
    ./packages.nix
    ./vm.nix
    ./gaming.nix
    ./keybinds.nix
    ./power-management.nix
    #./pentesting.nix
    ./security.nix
    ./boot.nix
  ];
}
