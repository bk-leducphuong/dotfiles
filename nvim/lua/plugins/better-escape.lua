-- Better Escape - Faster escape from insert mode
return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  config = function()
    require("better_escape").setup({
      mapping = { "jk", "jj" }, -- jk or jj to escape
      timeout = 200,
      clear_empty_lines = false,
      keys = "<Esc>",
    })
  end,
}
