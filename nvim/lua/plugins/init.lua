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
  require("plugins.mason-workaround"),
  require("plugins.lsp"),
  require("plugins.completion"),

  -- EDITING & UX
  require("plugins.editor"),
  require("plugins.nvim-ts-autotag"),

  -- GIT
  require("plugins.version-control"),

  -- UTILITIES
  require("plugins.terminal"),
  require("plugins.linting"),
  require("plugins.formatter"),

  -- DEBUG 
  require("plugins.debugprint"),
  require("plugins.trouble"),

  --- TMUX
  require("plugins.tmux"),
  require("plugins.tmux-navigation"),
}

