-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	-- Mason (LSP installer)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local servers = {
				volar = {
					filetypes = { "vue" },
				},
				eslint = {
					settings = {
						format = { enable = true },
					},
				},
				-- Add more server-specific configs here
			}

			require("mason-lspconfig").setup({
				ensure_installed = {
					"volar",
					"eslint",
					"html",
					"cssls",
					-- "tailwindcss",
					-- "jsonls",
				},
				automatic_installation = false,
				handlers = {
					function(server_name)
						if server_name == "tsserver" or server_name == "ts_ls" then
							return
						end
						local opts = servers[server_name] or {}
						require("lspconfig")[server_name].setup(opts)
					end,
				},
			})
		end,
	},
	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- Diagnostic signs
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = "󰠠 ",
				Info = " ",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- On attach function for keymaps
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true, noremap = true }

				-- Navigation
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to definition" })
				)
				vim.keymap.set(
					"n",
					"gr",
					"<cmd>Telescope lsp_references<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to references" })
				)
				vim.keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to implementation" })
				)
				vim.keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to type definition" })
				)

				-- Hover and help
				vim.keymap.set(
					"n",
					"K",
					vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "Hover documentation" })
				)
				vim.keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					vim.tbl_extend("force", opts, { desc = "Signature help" })
				)

				-- Code actions
				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code action" })
				)
				vim.keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "Rename symbol" })
				)

				-- Diagnostics
				vim.keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Show diagnostics" })
				)
				vim.keymap.set(
					"n",
					"[d",
					vim.diagnostic.goto_prev,
					vim.tbl_extend("force", opts, { desc = "Previous diagnostic" })
				)
				vim.keymap.set(
					"n",
					"]d",
					vim.diagnostic.goto_next,
					vim.tbl_extend("force", opts, { desc = "Next diagnostic" })
				)
				vim.keymap.set(
					"n",
					"<leader>dl",
					vim.diagnostic.setloclist,
					vim.tbl_extend("force", opts, { desc = "Diagnostics location list" })
				)
				vim.keymap.set(
					"n",
					"<leader>dq",
					vim.diagnostic.setqflist,
					vim.tbl_extend("force", opts, { desc = "Diagnostics quickfix list" })
				)

				-- Formatting
				if client:supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, vim.tbl_extend("force", opts, { desc = "Format document" }))
				end

				-- Make on_attach available to other plugin configs (e.g., typescript-tools)
				vim.g._global_lsp_on_attach = on_attach
			end

			-- Get capabilities from nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			-- Volar (Vue)
			-- Renamed from 'volar' to 'vue_ls'
			lspconfig.vue_ls.setup({
				root_dir = function(...)
					return require("lspconfig.util").root_pattern(".git")(...)
				end,
				on_attach = on_attach,
				capabilities = capabilities,
				-- Restrict to only Vue files to avoid TS/JS takeover
				filetypes = { "vue" },
			})

			-- TypeScript/JavaScript is handled by typescript-tools.nvim

			-- ESLint
			lspconfig.eslint.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					workingDirectories = { mode = "auto" },
				},
			})

			-- HTML
			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- CSS
			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- Tailwind CSS
			-- lspconfig.tailwindcss.setup({
			-- 	root_dir = function(...)
			-- 		return require("lspconfig.util").root_pattern(".git", "tailwind.config.js", "tailwind.config.cjs")(
			-- 			...
			-- 		)
			-- 	end,
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		tailwindCSS = {
			-- 			experimental = {
			-- 				classRegex = {
			-- 					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })

			-- JSON
			-- 	lspconfig.jsonls.setup({
			-- 		on_attach = on_attach,
			-- 		capabilities = capabilities,
			-- 		filetypes = { "json", "jsonc" },
			-- 		settings = {
			-- 			json = {
			-- 				schemas = require("schemastore").json.schemas(),
			-- 				validate = { enable = true },
			-- 			},
			-- 		},
			-- 	})
		end,
	},
}
