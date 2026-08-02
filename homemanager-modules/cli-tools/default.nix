{ config, lib, ... }:
{
  imports = [
    ./git.nix
    ./tmux.nix
    ./shell.nix
  ];

  config.tmux-conf.enable = lib.mkIf config.variables.is_headless true;
  # Variables are generally defined in the root ./variables.nix but are overriden in the hosts/WHATEVERHOST/configuration.nix
}
