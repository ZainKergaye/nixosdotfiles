{...}: {
  programs.nixvim.plugins = {
    lualine.enable = true;
    lualine.theme = "horizon";
    lualine.disabledFiletypes.statusline = [
      "NvimTree"
    ];

    which-key = {
      enable = true;
      window.border = "double";
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

    treesitter = {
      enable = true;
      indent = true;
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
        ignore = true;
      };
      renderer.highlightGit = true;
    };

    navic.enable = true;

  };
}
