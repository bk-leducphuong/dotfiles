-- TypeScript Tools - Enhanced TypeScript/JavaScript development
return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	opts = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		return {
			on_attach = function(client, bufnr)
				-- Reuse general LSP keymaps if defined globally
				if vim.g._global_lsp_on_attach then
					pcall(vim.g._global_lsp_on_attach, client, bufnr)
				end
			end,
			capabilities = capabilities,
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "none",
				},
				separate_diagnostic_server = false,
				tsserver_max_memory = 4096,
			},
		}
	end,
}
