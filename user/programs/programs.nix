# Imported into home-manager
{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./cava.nix
    ./peaclock.nix
    ./nixvim/nixvim.nix
    ./kitty.nix
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    firefox
		#zapzap
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
