# Imported into home-manager
{...}: {
  imports = [
    ./alacritty.nix
    ./cava.nix
	./peaclock.nix
	./nixvim/nixvim.nix
	./kitty.nix
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
