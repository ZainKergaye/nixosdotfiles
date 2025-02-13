{ pkgs, ... }: {
  home.packages = with pkgs; [
    svls
  ];
  programs.nixvim.plugins.lsp.servers.svls = {
    enable = true;
    filetypes = [ "v" "verilog" "systemverilog" ];
  };
}
