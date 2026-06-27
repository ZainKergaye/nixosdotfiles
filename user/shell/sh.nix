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
    upgrade = "sudo nixos-rebuild switch --flake /home/${config.variables.username}/.dotfiles/.#thinkpad";
    c = "python3 -Bqic 'from math import *'";
    peaclock = "peaclock --config-dir=/home/${config.variables.username}/.config/peaclock/";
    restart-waybar = "pkill waybar && hyprctl dispatch exec waybar";
    neofetch = "fastfetch";
    t = "${lib.getExe' pkgs.trashy "trash"}";
    rm = lib.getExe (
      pkgs.writeShellScriptBin "rm-confirmation" ''
        read -r -p "Really run rm? Type 'yes' to continue: " ans
        if [[ "$ans" != "yes" ]]; then
          echo "Aborted."
          exit 1
        fi
        exec ${lib.getExe' pkgs.coreutils "rm"} "$@"
      ''
    );
    g = lib.getExe' pkgs.git "git";
  };
in
{
  home.packages = with pkgs; [
    comma
    zoxide
    trashy
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
