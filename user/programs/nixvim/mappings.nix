{ ... }: 

{
  programs.nixvim = {
    keymaps = [
      {
      key = "<esc>";
      action = ":noh<CR>";
      mode = "n";
      options = {
	silent = true;
	desc = "Clear search";
	};
      }

      {
      key = "<leader>fm";
      action = ":lua require('conform').format()<CR>";
      mode = "n";
      options = {
	silent = false;
	desc = "Format Files";
	};
      }
    ];
  };
}
