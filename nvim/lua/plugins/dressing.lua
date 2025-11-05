-- Dressing - Better UI for select (input handled by Noice)
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      -- Disable dressing input - let Noice handle vim.ui.input
      enabled = false,
    },
    select = {
      -- Keep select enabled for better UI with Telescope
      enabled = true,
      backend = { "telescope", "builtin" },
      telescope = require("telescope.themes").get_dropdown(),
    },
  },
}
