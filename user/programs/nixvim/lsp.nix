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
          rust-analyzer.enable = false;
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
        formattersByFt = {
          nix = ["alejandra"]; # Nix formatter
          "_" = ["prettierd"]; # default formatter
          java = ["astyle"]; # Java formatting
        };
      };
    };

    # Managing preview width for cmp window
    extraConfigLuaPost = ''

      local ELLIPSIS_CHAR = '…'
      local MAX_LABEL_WIDTH = 25
      local MAX_KIND_WIDTH = 24

      local get_ws = function (max, len)
        return (" "):rep(max - len)
      end

      local format = function(_, item)
        local content = item.abbr
        -- local kind_symbol = symbols[item.kind]
        -- item.kind = kind_symbol .. get_ws(MAX_KIND_WIDTH, #kind_symbol)

        if #content > MAX_LABEL_WIDTH then
          item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
        else
          item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
        end

        return item
      end

      cmp.setup({
        formatting = {
          format = format,
        },
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
