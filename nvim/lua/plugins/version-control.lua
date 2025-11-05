return {
	-- git conflict
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "VeryLazy", -- Lazy load to reduce startup warnings
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				default_commands = true,
				disable_diagnostics = false,
				list_opener = "copen",
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})

			-- Keybindings
			vim.keymap.set("n", "<leader>co", "<Plug>(git-conflict-ours)", { desc = "Choose Ours" })
			vim.keymap.set("n", "<leader>ct", "<Plug>(git-conflict-theirs)", { desc = "Choose Theirs" })
			vim.keymap.set("n", "<leader>cb", "<Plug>(git-conflict-both)", { desc = "Choose Both" })
			vim.keymap.set("n", "<leader>c0", "<Plug>(git-conflict-none)", { desc = "Choose None" })
			vim.keymap.set("n", "<leader>cn", "<Plug>(git-conflict-next-conflict)", { desc = "Next Conflict" })
			vim.keymap.set("n", "<leader>cp", "<Plug>(git-conflict-prev-conflict)", { desc = "Prev Conflict" })
			vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictListQf<CR>", { desc = "List Conflicts" })
		end,
	},
	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},

				-- >> ENABLE BLAME HERE <<
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 500, -- Delay in milliseconds before displaying blame
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			})
		end,
	},
}
