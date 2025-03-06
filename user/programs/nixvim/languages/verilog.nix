{ pkgs, ... }: {
  home.packages = with pkgs; [
    verible
  ];
  programs.nixvim.plugins = {
    lsp.servers.verible = {
      enable = true;
      cmd =
        let
          rules =
            pkgs.writeText ".rules.verible_lint"
              # Because SystemVerilog is a superset of Verilog,
              # many of the linter rules suggest changes that are not
              # valid in Verilog, such as the use of keywords like always_comb.
              ''
                parameter-name-style=localparam_style:ALL_CAPS
                -always-comb
                -explicit-parameter-storage-type
                -unpacked-dimensions-range-ordering
              '';
        in
        [ "${pkgs.verible}/bin/verible-verilog-ls" "--rules_config ${rules}" ];
    };
    none-ls.sources.formatting.verible_verilog_format.enable = true;
    # NOTE: DOES NOT WORK
  };
}
