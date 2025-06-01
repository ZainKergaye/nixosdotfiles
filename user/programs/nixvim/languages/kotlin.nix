{ pkgs, ... }: {
  home.packages = with pkgs; [
  ];
  programs.nixvim.plugins = {
    lsp.servers.kotlin_language_server = {
      enable = true;
    };
    none-ls.sources.formatting.ktlint.enable = true;
    none-ls.sources.diagnostics.ktlint.enable = true;
  };
}
