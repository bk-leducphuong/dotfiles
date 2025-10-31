-- ~/.config/nvim/lua/plugins/init.lua

return {
	-- UI & THEME
	require("plugins.colorscheme"),
	require("plugins.lualine"),
	require("plugins.nvim-tree"),
	require("plugins.welcome-screen"),
	-- require("plugins.dressing"),
	require("plugins.indent"),
	require("plugins.noice"),

	-- CORE FUNCTIONALITY
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.navic"),

	-- LSP & COMPLETION
	require("plugins.mason-workaround"),
	require("plugins.lsp"),
	require("plugins.completion"),
	require("plugins.typescript-tools"),
	require("plugins.supermaven"),

	-- EDITING & UX
	require("plugins.editor"),
	require("plugins.nvim-ts-autotag"),
	require("plugins.better-escape"),
	require("plugins.mini"),
	require("plugins.ufo"),

	-- CODE NAVIGATION & ANALYSIS
	require("plugins.symbols-outline"),
	-- require("plugins.bqf"),

	-- TYPESCRIPT/JAVASCRIPT TOOLS
	require("plugins.package-info"),
	-- require("plugins.refactoring"),

	-- GIT
	require("plugins.version-control"),

	-- UTILITIES
	require("plugins.terminal"),
	require("plugins.linting"),
	require("plugins.formatter"),
	require("plugins.persistence"),

	-- DEBUG
	require("plugins.debugprint"),
	require("plugins.trouble"),

	-- TMUX
	require("plugins.tmux-navigation"),

	-- FIND AND REPLACE
	require("plugins.spectre"),
}
