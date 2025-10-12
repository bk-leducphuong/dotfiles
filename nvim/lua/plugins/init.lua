-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- UI & THEME
  require("plugins.colorscheme"),
  require("plugins.lualine"),
  require("plugins.nvim-tree"),

  -- CORE FUNCTIONALITY
  require("plugins.telescope"),
  require("plugins.treesitter"),

  -- LSP & COMPLETION
  require("plugins.lsp"),
  require("plugins.completion"),

  -- EDITING & UX
  require("plugins.editor"),

  -- GIT
  require("plugins.version-control"),

  -- UTILITIES
  require("plugins.terminal"),
  require("plugins.linting"),
  require("plugins.formatter"),

  -- DEBUG 
  require("plugins.debugprint")
}

