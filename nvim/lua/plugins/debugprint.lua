return {

  -- Debug Print
  {
    "andrewferrier/debugprint.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("debugprint").setup({
        keymaps = {
          normal = {
            plain_below = "g?p",
            plain_above = "g?P",
            variable_below = "g?v",
            variable_above = "g?V",
            variable_below_alwaysprompt = nil,
            variable_above_alwaysprompt = nil,
            textobj_below = "g?o",
            textobj_above = "g?O",
            toggle_comment_debug_prints = "g?t",
            delete_debug_prints = "g?d",
          },
          visual = {
            variable_below = "g?v",
            variable_above = "g?V",
          },
        },
        commands = {
          toggle_comment_debug_prints = "ToggleCommentDebugPrints",
          delete_debug_prints = "DeleteDebugPrints",
        },
        display_counter = true,
        display_snippet = true,
      })

      -- Custom keybindings (easier to remember)
      vim.keymap.set("n", "<leader>dp", "g?p", { remap = true, desc = "Debug print below" })
      vim.keymap.set("n", "<leader>dP", "g?P", { remap = true, desc = "Debug print above" })
      vim.keymap.set("n", "<leader>dv", "g?v", { remap = true, desc = "Debug variable below" })
      vim.keymap.set("n", "<leader>dV", "g?V", { remap = true, desc = "Debug variable above" })
      vim.keymap.set("n", "<leader>dt", "g?t", { remap = true, desc = "Toggle debug comments" })
      vim.keymap.set("n", "<leader>dd", "g?d", { remap = true, desc = "Delete all debug prints" })
      vim.keymap.set("v", "<leader>dv", "g?v", { remap = true, desc = "Debug variable" })
    end,
  },
}
