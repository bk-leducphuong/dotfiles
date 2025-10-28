-- Mini - Collection of useful mini plugins
return {
	-- {
	--   "echasnovski/mini.surround",
	--   version = false,
	--   event = "VeryLazy",
	--   opts = {
	--     mappings = {
	--       add = "gsa", -- Add surrounding in Normal and Visual modes
	--       delete = "gsd", -- Delete surrounding
	--       find = "gsf", -- Find surrounding (to the right)
	--       find_left = "gsF", -- Find surrounding (to the left)
	--       highlight = "gsh", -- Highlight surrounding
	--       replace = "gsr", -- Replace surrounding
	--       update_n_lines = "gsn", -- Update `n_lines`
	--     },
	--   },
	-- },
	-- {
	--   "echasnovski/mini.ai",
	--   version = false,
	--   event = "VeryLazy",
	--   config = function()
	--     require("mini.ai").setup({
	--       n_lines = 500,
	--     })
	--   end,
	-- },
	{
		"echasnovski/mini.bufremove",
		version = false,
		keys = {
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
