{...}:
{
imports = [
  ./mappings.nix
];

programs.nixvim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;

  globals.mapleader = " ";

  opts = {
    shiftwidth = 2;
  };

  colorschemes.catppuccin = {
    enable = true;
    settings.flavour = "mocha";
  };

  plugins = {
    lualine.enable = true;
    lualine.theme = "horizon";

    which-key = {
      enable = true;
      window.border = "double";
    };

    lsp = {
      enable = true;
      servers = {
	nil_ls.enable = true; # LS for Nix
      };
    };

    cmp = {
      enable = true;
    };
  };
};

}
