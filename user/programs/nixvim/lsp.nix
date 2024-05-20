{pkgs, ...}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true; # LS for Nix
        java-language-server = {
          enable = true;
          cmd = ["/home/aegis/.start-jdt-server"];
          package = pkgs."jdt-language-server";
        };
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
        #{ name = "nvim_lsp_signature_help"; }

        # Filesystem paths {name = "path";}

        # Buffer CMP
        {name = "buffer";}

        # Snippets
        {name = "snippy";}
        #{ name = "luasnip"; } Maybe not needed. Tryig Snippy
      ];
    };

    conform-nvim = {
      enable = true;
      formattersByFt = {
        nix = ["alejandra"]; # Nix formatter
        "_" = ["prettierd"]; # default formatter
      };
    };
  };

  home.file = {
    ".start-jdt-server" = {
      text = "jdtls -data ./.jdt-data";
      executable = true;
    };
  };
}
