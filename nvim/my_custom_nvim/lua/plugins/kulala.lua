return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		-- Enable global keymaps (only work in http/rest files)
		global_keymaps = true,
		-- Prefix for all kulala keymaps (e.g., <leader>s, <leader>a, etc.)
		global_keymaps_prefix = "<leader>k",

		-- Keymaps prefix for kulala window-specific actions (empty = no prefix)
		kulala_keymaps_prefix = "",

		-- Default request timeout in milliseconds (nil = no timeout)
		request_timeout = 10000,

		-- UI display mode: "split" or "float"
		ui = {
			display_mode = "float",
			-- Format JSON when redirecting to file
			format_json_on_redirect = true,
		},
	},
}
