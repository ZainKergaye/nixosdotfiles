{...}: let
  myAliases = {
    la = "ls -la";
    update = "nix flake update /home/aegis/.dotfiles/.";
    upgrade = "sudo nixos-rebuild switch --flake /home/aegis/.dotfiles/.";
    homeupgrade = "home-manager switch --flake /home/aegis/.dotfiles/.";
  };
in {
  programs.bash = {
    enable = true;
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
