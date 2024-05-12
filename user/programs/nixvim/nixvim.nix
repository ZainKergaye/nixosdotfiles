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

    lspkind.enable = true; # Icons for CMP
    cmp-nvim-lsp-signature-help.enable = true;
    cmp = {
      enable = true;
      settings.sources = [
	# LSP
	{ name = "nvim_lsp"; }
	#{ name = "nvim_lsp_signature_help"; }

	# Filesystem paths
	{ name = "path"; }

	# Buffer CMP 
	{ name = "buffer"; }

	# Snippets
	{ name = "snippy"; }
	#{ name = "luasnip"; } Maybe not needed. Tryig Snippy
      ];
    };

    conform-nvim = {
      enable = true;
      formattersByFt = {
	nix = [ "alejandra" ];
      };
    };
  };
};
}
