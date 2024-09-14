{ pkgs, ... }: {
  programs.nixvim.plugins = {
    lualine.enable = true;
    lualine.settings.optionstheme = "horizon";
    lualine.settings.options.disabledFiletypes.statusline = [
      "NvimTree"
    ];

    which-key = {
      enable = true;
    };

    bufferline = {
      enable = true;

      settings.options = {
        buffer_close_icon = null;
        close_icon = null;
        always_show_bufferline = false;
        separator_style = "slant";
        diagnostics = "nvim_lsp";
        offsets = [
          { filetype = "NvimTree"; }
          { text = "File Explorer"; }
          { highlight = "Directory"; }
          { separator = true; }
        ];
      };
    };

    treesitter = {
      enable = true;
      settings.indent.enable = true;
    };

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
        ignore = false;
      };
      renderer = {
        highlightGit = true;
        rootFolderLabel = false;
        indentMarkers.enable = true;
        icons = {
          glyphs = {
            default = "󰈚 ";
            folder = {
              default = " ";
              empty = " ";
              emptyOpen = " ";
              open = " ";
              symlink = " ";
            };
            git = {
              unmerged = "";
            };
          };
        };
      };
      view.side = "right";
    };

    navic.enable = false; # Not setup

    transparent.enable = false; # Not working

    indent-blankline = {
      enable = true;
      settings = {
        scope = {
          show_end = false;
          show_exact_scope = true;
          show_start = false;
        };
      };
    };

    telescope.enable = true;

    notify.enable = true;

    nvim-colorizer.enable = true;
  };
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.wrapping-nvim;
      config = ''lua require("wrapping").setup()'';
    }
  ];
}
