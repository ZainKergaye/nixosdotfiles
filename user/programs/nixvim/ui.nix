{ pkgs
, lib
, ...
}: {
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      settings = {
        optionstheme = "horizon";
        settings.options.disabledFiletypes.statusline = [
          "NvimTree"
          "nvim-tree"
        ];
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

    image.enable = true; # image support

    illuminate = {
      enable = true; # Used to illuminate same words
      filetypesDenylist = [
        "dirvish"
        "fugitive"
        "nvimtree"
        "nvim-tree"
        "NvimTree"
      ];
    };
  };
  programs.nixvim.extraPlugins = [
    {
      plugin = pkgs.vimPlugins.wrapping-nvim;
    }
    (pkgs.vimUtils.buildVimPlugin {
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
