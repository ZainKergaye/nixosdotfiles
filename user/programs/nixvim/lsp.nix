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
    };

    # Ability to toggle cmp
    extraConfigLua = ''

           local format_enabled = true
             vim.api.nvim_create_user_command("ToggleFormatNotified", function()
       if format_enabled then
      vim.cmd("FormatDisable")
                    require("notify")("Disabled formatting")
            		format_enabled = false
            	else
      vim.cmd("FormatEnable")
                    require("notify")("Enabled formatting")
            		format_enabled = true
             	end
            end, {})

    '';
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
        action = "<cmd> FormatToggleNotified <CR>";
        mode = "n";
        options.desc = "Format Toggle";
      }
    ];
  };

  home.file.".start-jdt-server" = {
    text = "jdtls -data ./.jdt-data";
    executable = true;
  };
}
