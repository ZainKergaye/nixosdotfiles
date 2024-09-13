{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil-ls.enable = true; # LS for Nix
          java-language-server = {
            enable = true;
            cmd = ["/home/aegis/.start-jdt-server"];
            package = pkgs."jdt-language-server";
          };
		  cssls.enable = true;
		  html.enable = true;
		  bashls.enable = true;
        };
      };

      nvim-jdtls = {
        enable = true;
        settings.java.gradle.enabled = true;
        data = "./.jdt-data";
      };

      lspkind.enable = true; # Icons for CMP

      cmp-nvim-lsp-signature-help.enable = true;
      cmp = {
        enable = true;
        settings.sources = [
          # LSP
          {name = "nvim_lsp";}
          {name = "nvim_lsp_signature_help";}

          # Filesystem paths
          {name = "path";}

          # Buffer CMP
          {name = "buffer";}

          # Snippets
          {name = "snippy";}
          {name = "luasnip";}

          {name = "cmp-dap";}
        ];
      };

      conform-nvim = {
        enable = true;
        settings.formattersByFt = {
          nix = ["alejandra"]; # Nix formatter
          "_" = ["prettierd"]; # default formatter
          java = ["astyle"]; # Java formatting
		  html = ["prettierd"];
          css = ["prettierd"];
        };
      };
    };
		extraConfigLua = /* lua */''
    local conform = require("conform")
    local notify = require("notify")

    conform.setup({
      format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    })

    local function show_notification(message, level)
      notify(message, level, { title = "conform.nvim" })
    end

    vim.api.nvim_create_user_command("FormatToggle", function(args)
      local is_global = not args.bang
      if is_global then
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        show_notification("Autoformat-on-save disabled globally", "info")
      else
        show_notification("Autoformat-on-save enabled globally", "info")
      end
      else
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      if vim.b.disable_autoformat then
        show_notification("Autoformat-on-save disabled for this buffer", "info")
      else
        show_notification("Autoformat-on-save enabled for this buffer", "info")
        end
      end
    end, {
      desc = "Toggle autoformat-on-save",
      bang = true,
    })
  '';
  };

  home.file = {
    ".start-jdt-server" = {
      text = "jdtls -data ./.jdt-data";
      executable = true;
    };
  };
}
