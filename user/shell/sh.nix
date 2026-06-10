{
  config,
  lib,
  pkgs,
  ...
}:
let
  myAliases = {
    la = "ls -la";
    update = "nix flake update --flake /home/${config.variables.username}/.dotfiles/.";
    upgrade = "sudo nixos-rebuild switch --flake /home/${config.variables.username}/.dotfiles/.#${config.networking.hostname}";
    homeupgrade = "home-manager switch --flake /home/${config.variables.username}/.dotfiles/.#${config.networking.hostName}";
    c = "python3 -Bqic 'from math import *'";
    peaclock = "peaclock --config-dir=/home/${config.variables.username}/.config/peaclock/";
    restart-waybar = "pkill waybar && hyprctl dispatch exec waybar";
    neofetch = "fastfetch";
  };
in
{
  home.packages = with pkgs; [
    comma
    zoxide
  ];
  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    bash = {
      enable = lib.mkDefault false; # Forces bash to be disabled unless some other file enables it
      shellAliases = myAliases;
    };

    zsh = {
      enable = true;
      shellAliases = myAliases;

      oh-my-zsh = {
        enable = true;
        theme = "miloshadzic";
        plugins = [
          "sudo"
          "colored-man-pages"
        ];
      };
      syntaxHighlighting.enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
