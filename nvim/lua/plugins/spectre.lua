-- ~/.config/nvim/lua/plugins/spectre.lua

return {
	"nvim-pack/nvim-spectre",
	-- You can also use `event = "VeryLazy"` if you don't want to use keymaps for lazy-loading
	dependencies = { "nvim-lua/plenary.nvim" },

	-- The keys are the recommended way to lazy-load Spectre.
	-- It will only be loaded when you press one of these keymaps.
	keys = {
		{
			"<leader>sr",
			"<cmd>Spectre<CR>",
			desc = "Replace in Project (Spectre)",
		},
		{
			"<leader>sw",
			'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
			desc = "Replace Word Under Cursor (Spectre)",
		},
		{
			-- You can also use this in Visual mode to search for the selected text
			mode = "v",
			"<leader>sr",
			'<cmd>lua require("spectre").open_visual()<CR>',
			desc = "Replace Selection (Spectre)",
		},
		{
			"<leader>sf",
			'<cmd>lua require("spectre").open_file_search()<CR>',
			desc = "Replace In Current File (Spectre)",
		},
	},

	-- This is where you can configure Spectre.
	-- The defaults are great, but here are some examples.
	opts = {
		-- To change the UI highlighting
		-- highlight = {
		--   ui = "SpectreUICSS",
		--   search = "SpectreSearch",
		--   replace = "SpectreReplace",
		-- },
		-- To set the mapping for "toggle replace" in the Spectre window
		-- maps = {
		--   toggle_replace = "<C-t>",
		-- },
	},
}
