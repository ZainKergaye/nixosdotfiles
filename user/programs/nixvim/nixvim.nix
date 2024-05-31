{...}: {
  imports = [
    ./mappings.nix
    ./lsp.nix
    ./ui.nix
		./dap.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      tabstop = 2;
      softtabstop = 2;
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
      neogen.enable = true;
    };
  };
}
