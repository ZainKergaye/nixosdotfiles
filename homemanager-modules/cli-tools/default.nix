{
  inputs,
  pkgs,
  config,
  lib,
  headless,
  ...
}:
{
  imports = [
    ./git.nix
    ./tmux.nix
    ./shell.nix
    ./cava.nix
    ./fastfetch.nix
    ./peaclock.nix
  ];

  config.tmux-conf.enable = lib.mkIf headless true;
  # Variables are generally defined in the root ./variables.nix but are overriden in the hosts/WHATEVERHOST/configuration.nix

  config.home.packages = with pkgs; [
    inputs.nixvim-custom.packages.${stdenv.hostPlatform.system}.default
    onefetch
    cbonsai
    yazi
  ];

}
