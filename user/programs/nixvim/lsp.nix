{ ... }: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # LS for Nix
          cssls.enable = true;
          html.enable = true;
          bashls.enable = true;
          pylsp.enable = true;
        };
      };

      noice.settings.presets."inc_rename" = true;
      inc-rename.enable = true; # Nice renaming UI
    };

    # Ability to toggle cmp
    extraConfigLua = ''
        local format_enabled = true
        vim.api.nvim_create_user_command(
            "ToggleFormatNotified",
            function()
                if format_enabled then
                    vim.cmd("FormatDisable")
                    require("notify")("Disabled formatting")
                    format_enabled = false
                else
                    vim.cmd("FormatEnable")
                    require("notify")("Enabled formatting")
                    format_enabled = true
                end
            end,
            {}
        )

      --   vim.diagnostic.config(
      --       {
      --           virtual_text = false,
      --           float = {border = "rounded"}
      --       }
      --   )
      --
      --   vim.o.updatetime = 250
      --   vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
      --   vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335 guifg=#abb2bf]])
      --
      -- '';
    keymaps = [
      {
        key = "<leader>fm";
        action = "<cmd> Format <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Format Files";
        };
      }

      {
        key = "<leader>tf";
        action = "<cmd> ToggleFormatNotified <CR>";
        mode = "n";
        options.desc = "Format Toggle";
      }

      {
        key = "<Leader>ra";
        action = "<cmd> IncRename <CR>";
        mode = "n";
        options.desc = "LSP Rename";
      }
    ];
  };
}
