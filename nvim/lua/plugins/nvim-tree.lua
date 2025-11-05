-- ~/.config/nvim/lua/plugins/nvim-tree.lua

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			view = { width = 35 },
			renderer = {
				icons = {
					show = { file = true, folder = true, folder_arrow = true, git = true },
				},
				group_empty = true,
			},
			filters = {
				custom = { ".git", "node_modules" },
			},
		})
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		vim.keymap.set("n", "<leader>r", function()
			local api = require("nvim-tree.api")
			api.tree.change_root(api.tree.get_node_under_cursor().absolute_path)
		end, { desc = "Set folder under cursor as root" })
	end,
}
