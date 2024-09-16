{ lib, ... }:
let
  user = "aegis";
  myAliases = {
    la = "ls -la";
    update = "nix flake update /home/${user}/.dotfiles/.";
    upgrade = "sudo nixos-rebuild switch --flake /home/${user}/.dotfiles/.";
    homeupgrade = "home-manager switch --flake /home/${user}/.dotfiles/.";
    c = "python3 -Bqic 'from math import *'";
    peaclock = "peaclock --config-dir=/home/${user}/.config/peaclock/";
  };
in
{
  programs.bash = {
    enable = lib.mkDefault false; # Forces bash to be disabled unless some other file enables it
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;

    oh-my-zsh = {
      enable = true;
      theme = "miloshadzic";
      plugins = [
        "sudo"
      ];
    };
    syntaxHighlighting.enable = true;
  };
}
