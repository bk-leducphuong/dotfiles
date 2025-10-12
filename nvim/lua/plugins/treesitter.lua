-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "typescript", "javascript", "tsx", "vue", "html", "css", "json", "lua", "vim" },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true }, -- For nvim-ts-autotag
    })
  end,
}
