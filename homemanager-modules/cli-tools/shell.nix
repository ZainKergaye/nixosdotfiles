{
  config,
  lib,
  pkgs,
  hostName,
  ...
}: let
  dotfilesDir = "/home/${config.variables.username}/.dotfiles";
  myAliases = {
    la = "ls -la";
    update = "nix flake update --flake /home/${config.variables.username}/.dotfiles/.";
    upgrade = lib.getExe (
      pkgs.writeShellScriptBin "upgrade" ''
        NIXOS_LABEL_VERSION="$(
          ${lib.getExe pkgs.git} -C ${dotfilesDir} log -1 --pretty=%s \
            | ${lib.getExe' pkgs.coreutils "tr"} -cs 'A-Za-z0-9:_.-' '-' \
            | ${lib.getExe pkgs.gnused} 's/^-*//; s/-*$//' \
            | ${lib.getExe' pkgs.coreutils "cut"} -c1-50
        )"
        export NIXOS_LABEL_VERSION
        sudo --preserve-env=NIXOS_LABEL_VERSION nixos-rebuild switch --impure --flake ${dotfilesDir}/.#${hostName}
      ''
    );
    c = "python3 -Bqic 'from math import *'";
    peaclock = "peaclock --config-dir=/home/${config.variables.username}/.config/peaclock/";
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
  };
in {
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
