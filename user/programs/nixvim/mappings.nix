{ ... }: 

{
  programs.nixvim = {

    plugins.which-key.registrations = {
      "<leader>f".name = "Find";
    };

    maps = {
      normal = {

      };
    };
  };
}
