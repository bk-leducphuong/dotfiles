return {
 {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = 'copen',
        highlights = {
          incoming = 'DiffAdd',
          current = 'DiffText',
        }
      })

      -- Keybindings
      vim.keymap.set('n', '<leader>co', '<Plug>(git-conflict-ours)', { desc = 'Choose Ours' })
      vim.keymap.set('n', '<leader>ct', '<Plug>(git-conflict-theirs)', { desc = 'Choose Theirs' })
      vim.keymap.set('n', '<leader>cb', '<Plug>(git-conflict-both)', { desc = 'Choose Both' })
      vim.keymap.set('n', '<leader>c0', '<Plug>(git-conflict-none)', { desc = 'Choose None' })
      vim.keymap.set('n', '<leader>cn', '<Plug>(git-conflict-next-conflict)', { desc = 'Next Conflict' })
      vim.keymap.set('n', '<leader>cp', '<Plug>(git-conflict-prev-conflict)', { desc = 'Prev Conflict' })
      vim.keymap.set('n', '<leader>cl', '<cmd>GitConflictListQf<CR>', { desc = 'List Conflicts' })
    end,
  },
}
