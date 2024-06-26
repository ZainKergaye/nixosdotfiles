{pkgs, ...}: {
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
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      clipboard.wl-copy.enable = true;
    };

    extraPackages = [
      pkgs.wl-clipboard
    ];

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
