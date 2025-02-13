{ pkgs, ... }: {
  home.packages = with pkgs; [
    dotnetCorePackages.dotnet_8.sdk
    csharpier
    netcoredbg
  ];

  programs.nixvim.plugins = {
    lsp.servers.omnisharp = {
      enable = true;
      cmd = [
        "${pkgs.dotnetCorePackages.dotnet_8.sdk}/bin/dotnet"
        "${pkgs.omnisharp-roslyn}/lib/omnisharp-roslyn/OmniSharp.dll"
      ];
    };

    none-ls.sources.formatting.csharpier.enable = true;

    neotest = {
      enable = true;
      adapters.dotnet.enable = true;
    };

    # dotnet.enable = true;

    dap = {
      #adapters.servers = [ "cs" ];

      configurations.cs = [
        {
          type = "coreclr";
          request = "launch";
          name = "launch - netcoredbg";
          program = ''
            function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
          '';
        }
      ];
    };
  };
}
