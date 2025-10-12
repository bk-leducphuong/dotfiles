-- ~/.config/nvim/lua/plugins/editor.lua

return {
  -- Auto pairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  -- Auto close tags
  { "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter/nvim-treesitter" },

  -- Commenting
  { "numToStr/Comment.nvim", config = true },

  -- Highlight same words (FIXED CONFIGURATION)
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        delay = 200,
        filetypes_denylist = {
          'NvimTree',
        },
        under_cursor = true,
      })

      -- Keymaps to jump between references
      vim.keymap.set('n', ']]', function() require('illuminate').goto_next_reference(false) end, { desc = "Next reference" })
      vim.keymap.set('n', '[[', function() require('illuminate').goto_prev_reference(false) end, { desc = "Previous reference" })
    end,
  },

  -- Better search highlighting
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      vim.keymap.set('n', 'n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
      vim.keymap.set('n', 'N', "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
    end
  },
}
