return {
	-- Git Conflict - Visual conflict resolution
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre", -- Load when reading files, not VeryLazy
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				default_commands = true,
				disable_diagnostics = false,
				list_opener = "copen",
				
				-- Custom highlight configuration
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
					ancestor = "DiffChange",
				},
				
				-- Only detect conflicts in actual files, not file explorers
				detect_in_buftype = { "" }, -- Empty string means normal buffers only
			})

			-- Create autocommand to disable git-conflict in nvim-tree
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "NvimTree", "neo-tree", "oil" },
				callback = function()
					vim.b.git_conflict_disable = true
				end,
			})

			-- ========================================
			-- Helper Functions for Bulk Operations
			-- ========================================
			
			-- Function to accept all "theirs" in current buffer
			local function accept_all_theirs()
				local cursor = vim.api.nvim_win_get_cursor(0)
				vim.cmd("normal! gg") -- Go to top of file
				
				local count = 0
				while true do
					-- Try to jump to next conflict
					local ok = pcall(vim.cmd, "GitConflictNextConflict")
					if not ok then
						break -- No more conflicts
					end
					
					-- Accept theirs
					vim.cmd("GitConflictChooseTheirs")
					count = count + 1
					
					-- Safety check to avoid infinite loop
					if count > 1000 then
						vim.notify("Too many conflicts! Stopped at 1000.", vim.log.levels.WARN)
						break
					end
				end
				
				-- Restore cursor or go to first line if nothing found
				pcall(vim.api.nvim_win_set_cursor, 0, cursor)
				
				if count > 0 then
					vim.notify(string.format("Accepted %d conflict(s) from 'theirs'", count), vim.log.levels.INFO)
				else
					vim.notify("No conflicts found", vim.log.levels.INFO)
				end
			end
			
			-- Function to accept all "ours" in current buffer
			local function accept_all_ours()
				local cursor = vim.api.nvim_win_get_cursor(0)
				vim.cmd("normal! gg") -- Go to top of file
				
				local count = 0
				while true do
					local ok = pcall(vim.cmd, "GitConflictNextConflict")
					if not ok then
						break
					end
					
					vim.cmd("GitConflictChooseOurs")
					count = count + 1
					
					if count > 1000 then
						vim.notify("Too many conflicts! Stopped at 1000.", vim.log.levels.WARN)
						break
					end
				end
				
				pcall(vim.api.nvim_win_set_cursor, 0, cursor)
				
				if count > 0 then
					vim.notify(string.format("Accepted %d conflict(s) from 'ours'", count), vim.log.levels.INFO)
				else
					vim.notify("No conflicts found", vim.log.levels.INFO)
				end
			end
			
			-- Function to accept all "both" in current buffer
			local function accept_all_both()
				local cursor = vim.api.nvim_win_get_cursor(0)
				vim.cmd("normal! gg")
				
				local count = 0
				while true do
					local ok = pcall(vim.cmd, "GitConflictNextConflict")
					if not ok then
						break
					end
					
					vim.cmd("GitConflictChooseBoth")
					count = count + 1
					
					if count > 1000 then
						vim.notify("Too many conflicts! Stopped at 1000.", vim.log.levels.WARN)
						break
					end
				end
				
				pcall(vim.api.nvim_win_set_cursor, 0, cursor)
				
				if count > 0 then
					vim.notify(string.format("Accepted %d conflict(s) choosing both", count), vim.log.levels.INFO)
				else
					vim.notify("No conflicts found", vim.log.levels.INFO)
				end
			end

			-- ========================================
			-- Create User Commands
			-- ========================================
			vim.api.nvim_create_user_command("GitConflictAcceptAllTheirs", accept_all_theirs, {
				desc = "Accept all 'theirs' in current buffer",
			})
			
			vim.api.nvim_create_user_command("GitConflictAcceptAllOurs", accept_all_ours, {
				desc = "Accept all 'ours' in current buffer",
			})
			
			vim.api.nvim_create_user_command("GitConflictAcceptAllBoth", accept_all_both, {
				desc = "Accept all conflicts choosing both in current buffer",
			})

			-- ========================================
			-- Keybindings
			-- ========================================
			
			-- Single conflict resolution
			vim.keymap.set("n", "<leader>co", "<Plug>(git-conflict-ours)", { desc = "Git: Choose Ours" })
			vim.keymap.set("n", "<leader>ct", "<Plug>(git-conflict-theirs)", { desc = "Git: Choose Theirs" })
			vim.keymap.set("n", "<leader>cb", "<Plug>(git-conflict-both)", { desc = "Git: Choose Both" })
			vim.keymap.set("n", "<leader>c0", "<Plug>(git-conflict-none)", { desc = "Git: Choose None" })
			
			-- Navigation
			vim.keymap.set("n", "<leader>cn", "<Plug>(git-conflict-next-conflict)", { desc = "Git: Next Conflict" })
			vim.keymap.set("n", "<leader>cp", "<Plug>(git-conflict-prev-conflict)", { desc = "Git: Previous Conflict" })
			
			-- List and refresh
			vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictListQf<CR>", { desc = "Git: List Conflicts" })
			vim.keymap.set("n", "<leader>cr", "<cmd>GitConflictRefresh<CR>", { desc = "Git: Refresh Conflicts" })
			
			-- Bulk operations (uppercase for "ALL")
			vim.keymap.set("n", "<leader>cT", accept_all_theirs, { desc = "Git: Accept ALL Theirs" })
			vim.keymap.set("n", "<leader>cO", accept_all_ours, { desc = "Git: Accept ALL Ours" })
			vim.keymap.set("n", "<leader>cB", accept_all_both, { desc = "Git: Accept ALL Both" })
		end,
	},
	
	-- Git Signs - Git decorations and blame
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
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
				
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				
				attach_to_untracked = true,
				
				-- Git blame settings
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 500,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				
				-- Update signs more frequently
				update_debounce = 100,
				
				-- Keymaps
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end
					
					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Next hunk" })
					
					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Previous hunk" })
					
					-- Actions
					map("n", "<leader>hs", gs.stage_hunk, { desc = "Git: Stage hunk" })
					map("n", "<leader>hr", gs.reset_hunk, { desc = "Git: Reset hunk" })
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: Stage hunk" })
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: Reset hunk" })
					map("n", "<leader>hS", gs.stage_buffer, { desc = "Git: Stage buffer" })
					map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git: Undo stage hunk" })
					map("n", "<leader>hR", gs.reset_buffer, { desc = "Git: Reset buffer" })
					map("n", "<leader>hp", gs.preview_hunk, { desc = "Git: Preview hunk" })
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, { desc = "Git: Blame line" })
					map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Git: Toggle blame" })
					map("n", "<leader>hd", gs.diffthis, { desc = "Git: Diff this" })
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end, { desc = "Git: Diff this ~" })
					map("n", "<leader>td", gs.toggle_deleted, { desc = "Git: Toggle deleted" })
					
					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select hunk" })
				end,
			})
		end,
	},
}
