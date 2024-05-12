{...}: {
  programs.nixvim = {
    keymaps = [ {
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
          silent = true;
          desc = "Format Files";
        };
      }

      # Line numbers
      {
        key = "<leader>n";
        action = "<cmd> set nu! <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle line number";
        };
      }

      {
        key = "<leader>rn";
        action = "<cmd> set rnu! <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Toggle relative line number";
        };
      }

      # buffer tabs
      {
        key = "<leader>b";
        action = "<cmd> enew <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "New buffer";
        };
      }

      {
        key = "<tab>";
        action = "<cmd> BufferLineCycleNext <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Next buffer";
        };
      }

      {
        key = "<S-tab>";
        action = "<cmd> BufferLineCycleNext <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Previous buffer";
        };
      }

      {
        key = "<leader>x";
        action = "<cmd> bdelete <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Delete buffer";
        };
      }
    ];
    plugins.cmp.settings.mapping = {
      "<Tab>" = "cmp.mapping.select_next_item()";
      "<S-Tab>" = "cmp.mapping.select_prev_item()";
      "<C-j>" = "cmp.mapping.scroll_docs(4)";
      "<C-k>" = "cmp.mapping.scroll_docs(-4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<Esc>" = "cmp.mapping.close()";
      "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
    };
  };
}
