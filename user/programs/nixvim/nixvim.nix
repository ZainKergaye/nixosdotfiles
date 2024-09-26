{ pkgs, ... }: {
  imports = [
    ./mappings.nix
    ./lsp.nix
    ./ui.nix
    #./dap.nix
    ./greeting.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    opts = {
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      clipboard.wl-copy.enable = true;
    };

    # Disables the mouse from messing with cursor
    extraConfigLua = ''
      vim.opt.mouse=""
    '';

    extraPackages = [
      pkgs.wl-clipboard
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      todo-comments = {
        enable = true;
        settings.keywords = {
          "HELP" = {
            icon = "󰮥 ";
            color = "warning";
            alt = [ "FUCK" "AAAA" "REEE" ];
          };
          "LABEL" = {
            icon = "󰌕 ";
            color = "info";
            alt = [ "FILL IN" ];
          };
          "DEPRICATED" = {
            icon = "󰁨 ";
            color = "warning";
            alt = [ "DEP" "UNEEDED" ];
          };
          "DEBUG" = {
            icon = " ";
            color = "#FF5747";
            alt = [ "TESTING" "REMOVELATER" "REMOVE" ];
          };
        };
      };

      fugitive.enable = true;
      neogen.enable = true;
    };
  };
}
