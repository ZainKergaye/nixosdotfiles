{ lib, config, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    # both are disabled if headless variable is set
  ];
}
