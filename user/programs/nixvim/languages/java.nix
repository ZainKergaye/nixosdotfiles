{ pkgs
, lib
, ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers =
        let
          start-jdt-server = lib.getExe (pkgs.writeShellScriptBin "start-jdt-server" "jdtls -data ./.jdt-data");
        in
        {
          java_language_server = {
            enable = true;
            cmd = [ "${start-jdt-server}" ];
            package = pkgs.jdt-language-server;
          };
        };
    };

    nvim-jdtls = {
      enable = true;
      settings.java.gradle.enabled = true;
      data = "./.jdt-data";
    };

    dap = {
      adapters.servers.java = {
        host = "127.0.0.1";
        port = 5006;
        id = "2";
        executable.command = ''
          config = function()
               require("java").setup {}
               require("lspconfig").jdtls.setup {
                 on_attach = require("plugins.configs.lspconfig").on_attach,
                 capabilities = require("plugins.configs.lspconfig").capabilities,
                 filetypes = { "java" },
               }
             end,
        '';
      };

      configurations.java = [
        {
          type = "java";
          request = "launch";
          #request = "attach";
          name = "Debug (Attach) - Remote";
          hostName = "127.0.0.1";
          port = 5005;
        }
      ];
    };
  };
}
