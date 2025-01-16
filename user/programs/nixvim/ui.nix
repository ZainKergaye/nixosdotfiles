{ pkgs, ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings.indent.enable = true;
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

    navic.enable = false; # Not setup

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

    colorizer = {
      enable = true;
      settings.user_default_options.names = false;
      settings.filetypes = [ "css" "scss" ];
    };

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

    web-devicons.enable = true;
    # Was forced to define this. Telescope, nvim-tree,
    # alpha, and bufferline use this already.

    wrapping.enable = true;
  };
  programs.nixvim.extraPlugins = [
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
    require('beacon').setup()
  '';
}
