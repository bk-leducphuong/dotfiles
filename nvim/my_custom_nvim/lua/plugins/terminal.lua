  -- Terminal
  return 
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 25
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        persist_size = true,
        persist_mode = true,
        direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          }
        },
        -- This is important for tmux integration
        on_create = function()
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
        end,
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
      
      -- Alternative with leader+number (easier to remember)
      -- vim.keymap.set("n", "<leader>1", "<cmd>1ToggleTerm<CR>", { desc = "Terminal 1" })
      -- vim.keymap.set("n", "<leader>2", "<cmd>2ToggleTerm<CR>", { desc = "Terminal 2" })
      -- vim.keymap.set("n", "<leader>3", "<cmd>3ToggleTerm<CR>", { desc = "Terminal 3" })
      -- vim.keymap.set("n", "<leader>4", "<cmd>4ToggleTerm<CR>", { desc = "Terminal 4" })
      -- vim.keymap.set("n", "<leader>5", "<cmd>5ToggleTerm<CR>", { desc = "Terminal 5" })

      -- Floating terminal for quick commands
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Floating terminal" })

      -- Toggle all terminals
      -- vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals" })
      
       -- Create custom terminal commands
      local Terminal = require('toggleterm.terminal').Terminal

      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
      })
      
      function _LAZYDOCKER_TOGGLE()
        lazydocker:toggle()
      end

      local gemini = Terminal:new({
        cmd = "gemini",
        direction = "float",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
      })
      
      function _GEMINI_TOGGLE()
        gemini:toggle()
      end

       vim.keymap.set('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<cr>', { desc = 'Toggle lazygit' })
       vim.keymap.set('n', '<leader>dd', '<cmd>lua _LAZYDOCKER_TOGGLE()<cr>', { desc = 'Toggle lazydocker' })
       vim.keymap.set('n', '<leader>gmi', '<cmd>lua _GEMINI_TOGGLE()<cr>', { desc = 'Toggle gemini' })
    end,
  }
