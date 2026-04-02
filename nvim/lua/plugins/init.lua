-- ~/.config/nvim/lua/plugins/init.lua

return {
	-- UI & THEME
	require("plugins.nvim-tree"), -- File explorer sidebar with tree view
	require("plugins.indent"), -- Indent guides/lines for better code readability
	require("plugins.noice"), -- Modern UI for messages, cmdline, and popupmenu

	-- CORE FUNCTIONALITY
	require("plugins.telescope"), -- Fuzzy finder for files, grep, buffers, etc.
	require("plugins.treesitter"), -- Advanced syntax highlighting and code parsing

	-- LSP & COMPLETION
	require("plugins.mason-workaround"), -- Workaround for Mason LSP installer issues
	require("plugins.lsp"), -- Language Server Protocol for code intelligence
	require("plugins.completion"), -- Autocompletion engine (nvim-cmp)
	require("plugins.typescript-tools"), -- Enhanced TypeScript/JavaScript LSP features
	require("plugins.supermaven"), -- AI code completion assistant

	-- EDITING & UX
	require("plugins.nvim-ts-autotag"), -- Auto-close and rename HTML/JSX tags

	-- GIT
	require("plugins.version-control"), -- Git integration (signs, blame, diff, etc.)

	-- UTILITIES
	require("plugins.terminal"), -- Integrated terminal with toggle keymaps
	require("plugins.linting"), -- Code linting with nvim-lint
	require("plugins.formatter"), -- Code formatting with conform.nvim
	require("plugins.persistence"), -- Session management to restore workspace state

	-- DEBUG
	require("plugins.debugprint"), -- Quick debug print statements
	require("plugins.trouble"), -- Pretty diagnostics and quickfix list

	-- TMUX
	require("plugins.tmux-navigation"), -- Seamless navigation between tmux and nvim panes

	-- FIND AND REPLACE
	require("plugins.spectre"), -- Advanced search and replace across project

	-- CURSOR ANIMATION
	require("plugins.smear_cursor"), -- Smooth cursor animation effects

	-- HTTP CLIENT
	require("plugins.kulala"), -- HTTP client for Neovim
}
