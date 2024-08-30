# Imported into home-manager
{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./cava.nix
	./peaclock.nix
	./nixvim/nixvim.nix
	./kitty.nix
  ];

	home.packages = [
		pkgs.firefox
	];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
