-- Noice (Better UI for messages, cmdline, and notifications)
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- You can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- Use classic bottom search
				command_palette = true, -- Position command palette at center
				long_message_to_split = true, -- Long messages sent to split
				inc_rename = false, -- Enables input dialog for inc-rename.nvim
				lsp_doc_border = false, -- Add border to hover docs and signature help
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
			},
		})

		-- Notify configuration
		require("notify").setup({
			background_colour = "#000000",
			fps = 60,
			render = "compact",
			timeout = 3000,
			top_down = false,
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice notifications" })
		vim.keymap.set("n", "<leader>nl", "<cmd>NoiceLast<CR>", { desc = "Show last message" })
		-- vim.keymap.set("n", "<leader>nh", "<cmd>NoiceHistory<CR>", { desc = "Show message history" })
	end,
}
