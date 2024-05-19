{...}: {
  imports = [
    ./mappings.nix
    ./lsp.nix
    ./ui.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      shiftwidth = 2;
      number = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {

      todo-comments.enable = true;
      fugitive.enable = true;
    };
  };
}
