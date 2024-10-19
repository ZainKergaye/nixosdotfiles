{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # LS for Nix
          java_language_server = {
            enable = true;
            cmd = [ "/home/aegis/.start-jdt-server" ];
            package = pkgs."jdt-language-server";
          };
          cssls.enable = true;
          html.enable = true;
          bashls.enable = true;
          pylsp.enable = true;
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
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }

          # Filesystem paths
          { name = "path"; }

          # Buffer CMP
          { name = "buffer"; }

          # Snippets
          { name = "snippy"; }
          { name = "luasnip"; }

          { name = "cmp-dap"; }
        ];
      };

      # LSP's used: css html nix bash java lua asm?
      # Completion path buffer snippy luasnip cmp-dap
      lsp-format.enable = true;
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources.formatting = {
          alejandra.enable = true;
          nixpkgs_fmt.enable = true;
          prettier.enable = true;
          prettierd.enable = true;
          stylua.enable = true;
        };
      };
    };

    # Ability to toggle cmp
    extraConfigLua = ''
      local cmp_enabled = true
        vim.api.nvim_create_user_command("ToggleAutoComplete", function()
        	if cmp_enabled then
        		require("cmp").setup.buffer({ enabled = false })
       require("notify")("Disabled Autocomplete")
        		cmp_enabled = false
        	else
        		require("cmp").setup.buffer({ enabled = true })
       require("notify")("Enabled Autocomplete")
        		cmp_enabled = true
        	end
        end, {})
    '';
    keymaps = [
      {
        key = "<Leader>ta";
        action = "<cmd> ToggleAutoComplete <CR>";
        mode = "n";
        options.desc = "Toggle Autocomplete";
      }
    ];
  };

  home.file = {
    ".start-jdt-server" = {
      text = "jdtls -data ./.jdt-data";
      executable = true;
    };
  };

  home.packages = with pkgs; [
    alejandra
    nixpkgs-fmt
    prettierd
    nixfmt-classic
    stylua
  ];
}
