-- ~/.config/nvim/lua/plugins/completion.lua
-- Autocompletion
return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp", -- Install jsregexp for transformations
			},
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = {
				preset = "default",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		config = function(_, opts)
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load({
				paths = "~/.config/nvim/snippets",
			})
			require("blink.cmp").setup(opts)
		end,
	},
	-- Autopairs (for (), {}, "", etc.)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Auto close + rename HTML tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = { enable = true },
			})
		end,
	},
}
