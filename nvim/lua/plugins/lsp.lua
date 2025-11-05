-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	-- Mason (LSP installer)
	{
		"williamboman/mason.nvim",
		version = "^2.0", -- Use latest v2.x version
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
					"volar", -- Vue
					"eslint", -- ESLint
					"html", -- HTML
					"cssls", -- CSS
					"jsonls", -- JSON (uncommented for better JSON support)
					-- "tailwindcss", -- Uncomment if using Tailwind
				},
				automatic_installation = false,
				handlers = {
					function(server_name)
						if server_name == "tsserver" or server_name == "ts_ls" then
							return -- typescript-tools.nvim handles TypeScript
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
			-- ========================================
			-- Diagnostic Configuration
			-- ========================================
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
					spacing = 4,
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
					focusable = false,
					format = function(diagnostic)
						-- Show error code if available
						if diagnostic.code then
							return string.format("%s [%s]", diagnostic.message, diagnostic.code)
						end
						return diagnostic.message
					end,
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

			-- ========================================
			-- On Attach Function (Keymaps & Settings)
			-- ========================================
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true, noremap = true }

				-- Enable inlay hints if available (Neovim 0.10+)
				if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					
					-- Toggle inlay hints keymap
					vim.keymap.set("n", "<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
					end, vim.tbl_extend("force", opts, { desc = "Toggle Inlay Hints" }))
				end

				-- Navigation
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to definition" }))
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to references" }))
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

				-- Hover and help
				vim.keymap.set("n", "K", vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
					vim.tbl_extend("force", opts, { desc = "Signature help" }))

				-- Code actions
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Code action" }))
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

				-- Diagnostics
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
					vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
					vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
				vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist,
					vim.tbl_extend("force", opts, { desc = "Diagnostics location list" }))
				vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist,
					vim.tbl_extend("force", opts, { desc = "Diagnostics quickfix list" }))

				-- Workspace
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
					vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
					vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

				-- Formatting (prefer conform.nvim, this is fallback)
				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, vim.tbl_extend("force", opts, { desc = "LSP Format document" }))
				end

				-- Document symbols
				vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>",
					vim.tbl_extend("force", opts, { desc = "Document symbols" }))
				vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
					vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

				-- Highlight symbol under cursor
				if client.server_capabilities.documentHighlightProvider then
					local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
					vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Make on_attach available to other plugin configs (e.g., typescript-tools)
				vim.g._global_lsp_on_attach = on_attach
			end

			-- ========================================
			-- Enhanced Capabilities
			-- ========================================
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			
			-- Enhanced completion capabilities
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.resolveSupport = {
				properties = { "documentation", "detail", "additionalTextEdits" },
			}

			local lspconfig = require("lspconfig")

			-- ========================================
			-- Volar (Vue) - Hybrid Mode
			-- ========================================
			lspconfig.volar.setup({
				root_dir = function(...)
					return require("lspconfig.util").root_pattern(
						"vue.config.js",
						"vite.config.ts",
						"vite.config.js",
						"nuxt.config.ts",
						"nuxt.config.js",
						"package.json",
						".git"
					)(...)
				end,
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "vue" },
				init_options = {
					vue = {
						hybridMode = false, -- Set to true if using Vue 2
					},
					typescript = {
						tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
					},
				},
				settings = {
					vue = {
						updateImportsOnFileMove = { enabled = true },
						inlayHints = {
							inlineHandlerLeading = true,
							missingProps = true,
							optionsWrapper = true,
							parameterNames = {
								enabled = "all",
								suppressWhenArgumentMatchesName = false,
							},
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = {
								enabled = true,
								suppressWhenTypeMatchesName = false,
							},
							vBindShorthand = true,
						},
						suggest = {
							autoImports = true,
						},
					},
				},
			})

			-- ========================================
			-- ESLint - Enhanced Configuration
			-- ========================================
			lspconfig.eslint.setup({
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					
					-- Auto-fix on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				capabilities = capabilities,
				settings = {
					codeAction = {
						disableRuleComment = {
							enable = true,
							location = "separateLine",
						},
						showDocumentation = {
							enable = true,
						},
					},
					codeActionOnSave = {
						enable = false, -- We handle this with the autocmd above
						mode = "all",
					},
					experimental = {
						useFlatConfig = false, -- Set to true if using ESLint flat config
					},
					format = true,
					nodePath = "",
					onIgnoredFiles = "off",
					packageManager = "npm",
					problems = {
						shortenToSingleLine = false,
					},
					quiet = false,
					rulesCustomizations = {},
					run = "onType",
					useESLintClass = false,
					validate = "on",
					workingDirectory = {
						mode = "auto",
					},
				},
			})

			-- ========================================
			-- HTML
			-- ========================================
			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html", "vue" },
			})

			-- ========================================
			-- CSS
			-- ========================================
			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
					less = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			})

			-- ========================================
			-- JSON with SchemaStore
			-- ========================================
			lspconfig.jsonls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "json", "jsonc" },
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
						format = { enable = true },
					},
				},
			})

			-- ========================================
			-- Tailwind CSS (Uncomment if needed)
			-- ========================================
			-- lspconfig.tailwindcss.setup({
			-- 	root_dir = function(...)
			-- 		return require("lspconfig.util").root_pattern(
			-- 			"tailwind.config.js",
			-- 			"tailwind.config.cjs",
			-- 			"tailwind.config.ts",
			-- 			"postcss.config.js",
			-- 			"postcss.config.cjs",
			-- 			"postcss.config.ts",
			-- 			"package.json",
			-- 			".git"
			-- 		)(...)
			-- 	end,
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		tailwindCSS = {
			-- 			classAttributes = { "class", "className", "classList", "ngClass" },
			-- 			lint = {
			-- 				cssConflict = "warning",
			-- 				invalidApply = "error",
			-- 				invalidConfigPath = "error",
			-- 				invalidScreen = "error",
			-- 				invalidTailwindDirective = "error",
			-- 				invalidVariant = "error",
			-- 				recommendedVariantOrder = "warning",
			-- 			},
			-- 			experimental = {
			-- 				classRegex = {
			-- 					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
			-- 					{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
			-- 					"tw`([^`]*)",
			-- 					"tw=\"([^\"]*)",
			-- 					"tw={\"([^\"}]*)",
			-- 					"tw\\.\\w+`([^`]*)",
			-- 					"tw\\(.*?\\)`([^`]*)",
			-- 				},
			-- 			},
			-- 			validate = true,
			-- 		},
			-- 	},
			-- })
		end,
	},
}
