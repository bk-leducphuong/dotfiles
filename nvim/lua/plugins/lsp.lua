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
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"volar",
					"eslint",
					"html",
					"cssls",
					"tailwindcss",
					"jsonls",
				},
				automatic_installation = true,
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
			end

			-- Get capabilities from nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			local mason_registry = require("mason-registry")

			-- Get Vue TypeScript Plugin path
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"

			-- TypeScript/JavaScript (with Vue support)
			lspconfig.ts_ls.setup({
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					local opts = { buffer = bufnr, silent = true, noremap = true }

					-- TypeScript-specific keymaps
					vim.keymap.set(
						"n",
						"<leader>co",
						"<cmd>TSToolsOrganizeImports<CR>",
						vim.tbl_extend("force", opts, { desc = "Organize imports" })
					)
					vim.keymap.set(
						"n",
						"<leader>cR",
						"<cmd>TSToolsRenameFile<CR>",
						vim.tbl_extend("force", opts, { desc = "Rename file" })
					)
					vim.keymap.set(
						"n",
						"<leader>ci",
						"<cmd>TSToolsAddMissingImports<CR>",
						vim.tbl_extend("force", opts, { desc = "Add missing imports" })
					)
					vim.keymap.set(
						"n",
						"<leader>cu",
						"<cmd>TSToolsRemoveUnused<CR>",
						vim.tbl_extend("force", opts, { desc = "Remove unused imports" })
					)
					vim.keymap.set(
						"n",
						"<leader>cf",
						"<cmd>TSToolsFixAll<CR>",
						vim.tbl_extend("force", opts, { desc = "Fix all" })
					)
					vim.keymap.set(
						"n",
						"gD",
						"<cmd>TSToolsGoToSourceDefinition<CR>",
						vim.tbl_extend("force", opts, { desc = "Go to source definition" })
					)
				end,
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
					preferences = {
						-- Disable inlay hints to save memory
						includeInlayParameterNameHints = "none",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = false,
						includeInlayVariableTypeHints = false,
						includeInlayPropertyDeclarationTypeHints = false,
						includeInlayFunctionLikeReturnTypeHints = false,
						includeInlayEnumMemberValueHints = false,
						importModuleSpecifierPreference = "relative",
						importModuleSpecifierEnding = "auto",
						-- Performance optimizations
						disableSuggestions = false,
					},
					-- Set memory limit for TypeScript server (in MB)
					maxTsServerMemory = 4096,
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "none",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = false,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = false,
							includeInlayFunctionLikeReturnTypeHints = false,
							includeInlayEnumMemberValueHints = false,
						},
						-- Performance settings
						tsserver = {
							maxTsServerMemory = 4096,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "none",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = false,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = false,
							includeInlayFunctionLikeReturnTypeHints = false,
							includeInlayEnumMemberValueHints = false,
						},
					},
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
			})

			-- Volar (Vue)
			lspconfig.volar.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

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
			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			})

			-- JSON
			lspconfig.jsonls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "json", "jsonc" },
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,
	},
}
