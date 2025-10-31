-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Tree-sitter is a C/C++ library that generates parsers for different languages, creating a detailed syntax tree of the code.
-- Neovim leverages this for a deeper understanding of the code structure.
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"typescript",
				"scss",
				"cmake",
				"gitignore",
				"cmake",
				"javascript",
				"tsx",
				"vue",
				"html",
				"css",
				"json",
				"lua",
				"vim",
			},
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true }, -- For nvim-ts-autotag
			folding = { enable = true },
		})
	end,
}
