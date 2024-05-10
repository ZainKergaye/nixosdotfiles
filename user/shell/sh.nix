{ config, lib, pkgs, ... }:

let 
  myAliases = {
    la = "ls -la";
    update = "nix flake update /home/zain/.dotfiles/.";
    upgrade = "sudo nixos-rebuild switch --flake /home/zain/.dotfiles/.";
    homeupgrade = "home-manager switch --flake /home/zain/.dotfiles/.";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;

    oh-my-zsh = {
      enable = true;
      theme = "jonathan";
      plugins = [
        "sudo"
      ];
    };
  };
}
