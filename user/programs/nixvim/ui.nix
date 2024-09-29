{ pkgs, ... }: {
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      settings = {
        optionstheme = "horizon";
        settings.options.disabled_filetypes = {
          # BUG: Still not hiding for nvim tree
          statusline = [
            "nvimtree"
            "NvimTree"
            "nvim-tree"
            "NvimTree_1"
          ];
          winbar = [
            "nvimtree"
            "NvimTree"
            "nvim-tree"
            "NvimTree_1"
          ];
        };
      };
    };

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
      hijackCursor = true;
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

    notify = {
      enable = true;
      render = "minimal";
    };

    nvim-colorizer.enable = true;

    image.enable = true; # image support

    illuminate = {
      enable = true; # Used to illuminate same words
      filetypesDenylist = [
        "adoc"
        "asciidoc"
        "dirvish"
        "fugitive"
        "nvimtree"
        "nvim-tree"
        "NvimTree"
      ];
    };

    noice.enable = true; # popup cmd prompt
  };
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.wrapping-nvim;
    }
    (pkgs.vimUtils.buildVimPlugin {
      # TODO: Add to nixvim plugins
      name = "beacon";
      src = pkgs.fetchFromGitHub {
        owner = "DanilaMihailov";
        repo = "beacon.nvim";
        rev = "v2.0.0";
        hash = "sha256-w5uhTVYRgkVCbJ5wrNTKs8bwSpH+4REAr9gaZrbknH8=";
      };
    })
  ];
  programs.nixvim.extraConfigLua = ''
    require("wrapping").setup()
    require('beacon').setup()
  '';
}
