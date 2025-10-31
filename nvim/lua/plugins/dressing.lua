-- Dressing - Better UI for input and select
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      -- Disable dressing input to let noice handle it
      enabled = false,
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin" },
      telescope = require("telescope.themes").get_dropdown(),
    },
  },
}
