  -- Terminal
  return 
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 45
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
        },
      })

      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      -- Keybindings for numbered terminals
      vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm<CR>", { desc = "Terminal 1" })
      vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm<CR>", { desc = "Terminal 2" })
      vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm<CR>", { desc = "Terminal 3" })
      vim.keymap.set("n", "<leader>t4", "<cmd>4ToggleTerm<CR>", { desc = "Terminal 4" })
      vim.keymap.set("n", "<leader>t5", "<cmd>5ToggleTerm<CR>", { desc = "Terminal 5" })
      
      -- Alternative with leader+number (easier to remember)
      vim.keymap.set("n", "<leader>1", "<cmd>1ToggleTerm<CR>", { desc = "Terminal 1" })
      vim.keymap.set("n", "<leader>2", "<cmd>2ToggleTerm<CR>", { desc = "Terminal 2" })
      vim.keymap.set("n", "<leader>3", "<cmd>3ToggleTerm<CR>", { desc = "Terminal 3" })
      vim.keymap.set("n", "<leader>4", "<cmd>4ToggleTerm<CR>", { desc = "Terminal 4" })
      vim.keymap.set("n", "<leader>5", "<cmd>5ToggleTerm<CR>", { desc = "Terminal 5" })

      -- Floating terminal for quick commands
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Floating terminal" })
      
      -- Toggle all terminals
      vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals" })
      
      -- Main toggle
      vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    end,
  }
