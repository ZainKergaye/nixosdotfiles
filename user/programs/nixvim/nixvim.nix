{...}: {
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
      number = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      lualine.enable = true;
      lualine.theme = "horizon";
      lualine.disabledFiletypes.statusline = [
        "NvimTree"
      ];

      which-key = {
        enable = true;
        window.border = "double";
      };

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # LS for Nix
	  java-language-server.enable = true;
        };
      };

      lspkind.enable = true; # Icons for CMP
      cmp-nvim-lsp-signature-help.enable = true;
      cmp = {
        enable = true;
        settings.sources = [
          # LSP
          {name = "nvim_lsp";}
          #{ name = "nvim_lsp_signature_help"; }

          # Filesystem paths {name = "path";}

          # Buffer CMP
          {name = "buffer";}

          # Snippets
          {name = "snippy";}
          #{ name = "luasnip"; } Maybe not needed. Tryig Snippy
        ];
      };

      conform-nvim = {
        enable = true;
        formattersByFt = {
          nix = ["alejandra"]; # Nix formatter
          "_" = ["prettierd"]; # default formatter
        };
      };

      bufferline = {
        enable = true;
        bufferCloseIcon = null;
        closeIcon = null;
        alwaysShowBufferline = false;
        separatorStyle = "slant";
        diagnostics = "nvim_lsp";
        offsets = [
          {filetype = "NvimTree";}
          {text = "File Explorer";}
          {highlight = "Directory";}
          {separator = true;}
        ];
      };

      treesitter.enable = true;

      toggleterm = {
        enable = true;
        settings.float_opts.border = "curved";
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "│";
          change.text = "│";
          delete.text = "│";
          topdelete.text = "󰍵";
          changedelete.text = "~";
          untracked.text = "│";
        };
      };

      nvim-autopairs.enable = true;

      nvim-tree = {
        enable = true;
        git = {
          enable = true;
          ignore = true;
        };
        renderer.highlightGit = true;
      };

      todo-comments = {
        enable = true;
      };
    };
  };
}
