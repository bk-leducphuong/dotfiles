return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { 
			"MunifTanjim/nui.nvim", 
			"rcarriga/nvim-notify",
		},
		opts = function(_, opts)
			opts = opts or {}
			opts.routes = opts.routes or {}
			opts.commands = opts.commands or {}
			opts.presets = opts.presets or {}
			opts.views = opts.views or {}
			
			-- Override vim.ui functions to use noice
			opts.lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			}
			
			-- Enable cmdline popup for search and commands
			opts.cmdline = {
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
			}

			opts.ui = {
				input = {
					enable = true, -- Make sure this is true

					-- === CUSTOMIZATION STARTS HERE ===

					-- Where the popup appears
					-- Try "5" (5th row) or "50%" (center)
					position = {
						row = "50%",
						col = "50%",
					},

					-- How big the popup is
					size = {
						width = 60,
						height = "auto",
					},

					-- What the border looks like
					border = {
						style = "rounded", -- "none", "single", "double", "rounded", "shadow"
						padding = { 1, 2 }, -- {vertical, horizontal}
					},

					-- The little icon on the left of the prompt
					prompt_icon = "❯ ", -- Try " " or "» " or "✏️ "

					-- The title of the popup
					title = " Input ", -- Add spaces for padding
				},

				-- You can also style the "confirm" popup
				-- when you (d)elete a file
				confirm = {
					position = { row = "50%", col = "50%" },
					border = { style = "rounded" },
				},
			}

			-- Configure cmdline popup view (for search and commands)
			opts.views.cmdline_popup = {
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
			}

			-- Configure popup menu (for command completion)
			opts.views.popupmenu = {
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
			}

			-- Configure notification views to appear at top
			opts.views.notify = {
				backend = "notify",
				fallback = "mini",
				position = {
					row = 1,
					col = "100%",
				},
			}

			opts.views.mini = {
				position = {
					row = 1,
					col = "100%",
				},
			}
			
			-- Configure input view specifically
			opts.views.input = {
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
			}

			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true

			return opts
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			top_down = true,
			stages = "fade_in_slide_out",
		},
	},
}
