# Imported into home-manager
{...}: {
  imports = [
    ./alacritty/alacritty.nix
		./cava.nix
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
