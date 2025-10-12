-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nordic").load()
	end,
}
