-- ~/.config/nvim/lua/plugins/telescope.lua

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
				file_ignore_patterns = { "node_modules", ".git", "dist", "build" },
				layout_config = {
					horizontal = {
						preview_width = 0.55,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				buffers = {
					show_all_buffers = true,
					sort_mru = true,
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						n = {
							["dd"] = actions.delete_buffer,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- ========================================
		-- Helper Functions
		-- ========================================

		-- Function to show only modified (unsaved) buffers
		local function show_modified_buffers()
			require("telescope.builtin").buffers({
				prompt_title = "Modified Buffers (Unsaved)",
				only_cwd = false,
				show_all_buffers = true,
				attach_mappings = function(_, map)
					-- Filter to show only modified buffers
					local entry_display = require("telescope.pickers.entry_display")
					return true
				end,
				-- Custom filter
				entry_maker = function(entry)
					local bufnr = entry.bufnr
					local is_modified = vim.api.nvim_buf_get_option(bufnr, "modified")

					if is_modified then
						return require("telescope.make_entry").gen_from_buffer()(entry)
					end
					return nil
				end,
			})
		end

		-- Function to list all modified files in git
		local function show_git_changed_files()
			local previewers = require("telescope.previewers")
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values

			-- Get git status
			local cmd = { "git", "status", "--porcelain" }
			local results = vim.fn.systemlist(cmd)

			if vim.v.shell_error ~= 0 then
				vim.notify("Not in a git repository", vim.log.levels.WARN)
				return
			end

			-- Parse results
			local files = {}
			for _, line in ipairs(results) do
				local status = line:sub(1, 2)
				local file = line:sub(4)
				table.insert(files, { status = status, file = file })
			end

			pickers
				.new({}, {
					prompt_title = "Git Changed Files",
					finder = finders.new_table({
						results = files,
						entry_maker = function(entry)
							return {
								value = entry.file,
								display = string.format("[%s] %s", entry.status, entry.file),
								ordinal = entry.file,
								path = entry.file,
							}
						end,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		-- Function to show unsaved buffers with indicator
		local function show_unsaved_buffers()
			local unsaved = {}

			-- Get all buffers
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(bufnr) then
					local is_modified = vim.api.nvim_buf_get_option(bufnr, "modified")
					local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
					local name = vim.api.nvim_buf_get_name(bufnr)

					-- Only show normal file buffers that are modified
					if is_modified and buftype == "" and name ~= "" then
						table.insert(unsaved, {
							bufnr = bufnr,
							name = name,
						})
					end
				end
			end

			if #unsaved == 0 then
				vim.notify("No unsaved files", vim.log.levels.INFO)
				return
			end

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local action_state = require("telescope.actions.state")

			pickers
				.new({}, {
					prompt_title = string.format("Unsaved Files (%d)", #unsaved),
					finder = finders.new_table({
						results = unsaved,
						entry_maker = function(entry)
							local filename = vim.fn.fnamemodify(entry.name, ":t")
							local dir = vim.fn.fnamemodify(entry.name, ":h:t")
							return {
								value = entry,
								display = string.format("[+] %s/%s", dir, filename),
								ordinal = entry.name,
								path = entry.name,
								bufnr = entry.bufnr,
							}
						end,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							vim.api.nvim_set_current_buf(selection.bufnr)
						end)
						return true
					end,
				})
				:find()
		end

		-- ========================================
		-- User Commands
		-- ========================================
		vim.api.nvim_create_user_command("TelescopeModifiedBuffers", show_unsaved_buffers, {
			desc = "Show unsaved/modified buffers",
		})

		vim.api.nvim_create_user_command("TelescopeGitChanged", show_git_changed_files, {
			desc = "Show git changed files",
		})

		-- ========================================
		-- Keybindings
		-- ========================================
		local keymap = vim.keymap

		-- File finding
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text (grep)" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word under cursor" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

		-- Buffer management
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
		keymap.set("n", "<leader>fu", show_unsaved_buffers, { desc = "Modified/Unsaved buffers" })

		-- Git integration
		keymap.set("n", "<leader>gc", show_git_changed_files, { desc = "Git changed files" })
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status (Telescope)" })
		keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
		keymap.set("n", "<leader>gC", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
		keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Git files" })

		-- LSP
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })

		-- Misc
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
		keymap.set("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Vim options" })
		keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix list" })
		keymap.set("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "Location list" })
		keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jump list" })
		keymap.set("n", "<leader>f/", "<cmd>Telescope search_history<cr>", { desc = "Search history" })
		keymap.set("n", "<leader>f:", "<cmd>Telescope command_history<cr>", { desc = "Command history" })
	end,
}
