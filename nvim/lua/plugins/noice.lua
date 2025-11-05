return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			-- Override LSP handlers
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
					["vim.lsp.buf.hover"] = true,
					["vim.lsp.buf.signature_help"] = true,
				},
			},

			-- Enable cmdline popup for search and commands
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = {
						kind = "search",
						pattern = "^/",
						icon = " ",
						icon_hl_group = "DiagnosticInfo",
						lang = "regex",
					},
					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = " ",
						icon_hl_group = "DiagnosticInfo",
						lang = "regex",
					},
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = {},
				},
			},

			-- Presets for common UI patterns
			presets = {
				bottom_search = false, -- use cmdline_popup for search
				command_palette = false, -- position command popup at top
				long_message_to_split = true, -- long messages to split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add border to hover and signature help
			},

			-- Configure views
			views = {
				-- Cmdline popup (for : commands and search)
				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},

				-- Popup menu (for command completion)
				popupmenu = {
					relative = "editor",
					position = {
						row = "60%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},

				-- Input popup (for vim.ui.input - rename, create file, etc.)
				input = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winblend = 0,
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},

				-- Confirm popup (for confirmations)
				confirm = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},

				-- Notification views
				notify = {
					backend = "notify",
					fallback = "mini",
					position = {
						row = 1,
						col = "100%",
					},
				},

				mini = {
					position = {
						row = 1,
						col = "100%",
					},
				},
			},

			-- Routes for filtering messages
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				},
				-- Route for focus gained/lost (keep background notifications quiet)
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "written" },
							{ find = "yanked" },
						},
					},
					view = "mini",
				},
			},

			-- Commands
			commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			},
		},
		keys = {
			{ "<leader>sn", "<cmd>Noice<cr>", desc = "Noice Messages" },
			{ "<leader>snl", "<cmd>NoiceLast<cr>", desc = "Noice Last Message" },
			{ "<leader>snh", "<cmd>NoiceHistory<cr>", desc = "Noice History" },
			{ "<leader>sna", "<cmd>NoiceAll<cr>", desc = "Noice All" },
			{ "<leader>snd", "<cmd>NoiceDismiss<cr>", desc = "Dismiss All Notifications" },
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			top_down = true,
			stages = "fade_in_slide_out",
			render = "default",
			max_width = 50,
		},
	},
}
