{...}: {
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
        action = "<cmd> BufferLineCyclePrev <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Previous buffer";
        };
      }
    {
      key = "<leader>x";
        action = ":bd <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Delete buffer";
        };
      }
      {
        key = "<leader>tp";
        action = "<cmd> BufferLineTogglePin <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Pin buffer";
        };
      }

      # Window movement
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
        options.desc = "Move down";
      }

      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
        options.desc = "Move up";
      }

      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
        options.desc = "Move left";
      }

      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
        options.desc = "Move right";
      }

      # Terminal
      {
        key = "<C-x>";
        action = "<C-\\><C-N>";
        mode = "t";
        options.desc = "Exit terminal";
      }

      {
        key = "<Leader>h";
        action = "<cmd> ToggleTerm direction=horizontal <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Horizontal terminal";
        };
      }

      {
        key = "<Leader>v";
        action = "<cmd>ToggleTerm direction=vertical size=60 <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Vertical terminal";
        };
      }

      {
        key = "<Leader>fw";
        action = "<cmd> ToggleTerm direction=float <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Floating terminal";
        };
      }

      # Git
      {
        key = "<Leader>gsr";
        action = ":Gitsigns reset_hunk <CR>";
        mode = "n";
        options.desc = "Reset hunk";
      }

      {
        key = "<Leader>gsh";
        action = ":Gitsigns stage_hunk <CR>";
        mode = "n";
        options.desc = "Stage hunk";
      }

      {
        key = "<Leader>gsu";
        action = ":Gitsigns undo_stage_hunk <CR>";
        mode = "n";
        options.desc = "Undo stage hunk";
      }

      {
        key = "<Leader>gh";
        action = ":Gitsigns preview_hunk <CR>";
        mode = "n";
        options.desc = "Preview hunk";
      }

      {
        key = "<Leader>gb";
        action = ":Gitsigns blame_line<CR>";
        mode = "n";
        options.desc = "Git blame";
      }

      # Tree
      {
        key = "<Leader>e";
        action = "<cmd> NvimTreeFocus <CR>";
        mode = "n";
        options.desc = "Focus tree";
      }

      {
        key = "<C-n>";
        action = "<cmd> NvimTreeToggle <CR>";
        mode = "n";
        options.desc = "Toggle tree";
      }

			# Telescope stuff
			{
				key = "<Leader>ff";
				action = "<cmd> Telescope fd <CR>";
				mode = "n";
				options.desc = "Find files";
			}

			{
				key = "<Leader>gsc";
				action = "<cmd> Telescope git_commits <CR>";
				mode = "n";
				options.desc = "Git show commits";
			}

			{
				key = "<Leader>fr";
				action = "<cmd> Telescope oldfiles <CR>";
				mode = "n";
				options.desc = "Find recents";
			}

			## LSP

			{
				key = "<Leader>rr";
				action = "vim.lsp.buf.rename()";
				mode = "n";
				options.desc = "LSP Rename";
			}
    ];

    plugins.cmp.settings.mapping = {
      "<Tab>" = "cmp.mapping.select_next_item()";
      "<S-Tab>" = "cmp.mapping.select_prev_item()";
      "<C-j>" = "cmp.mapping.scroll_docs(4)";
      "<C-k>" = "cmp.mapping.scroll_docs(-4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-Esc>" = "cmp.mapping.close()";
      "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
    };

    plugins.lsp.keymaps.lspBuf = {
      "K" = "hover";
      "<Leader>gD" = "references";
      "<Leader>gd" = "definition";
    };

    plugins.which-key.registrations = {
      "<Leader>gD" = "Goto reference";
      "<Leader>gd" = "Goto definition";
	  "<Leader>d" = "DAP options";
	  "<Leader>g" = "Git options";
	  "<Leader>gs" = "Stage options";
    };
  };
}
