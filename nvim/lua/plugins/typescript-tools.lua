-- TypeScript Tools - Enhanced TypeScript/JavaScript development
return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	opts = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		
		-- Enhanced capabilities for better autocompletion
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" },
		}

		return {
			on_attach = function(client, bufnr)
				-- Reuse general LSP keymaps if defined globally
				if vim.g._global_lsp_on_attach then
					pcall(vim.g._global_lsp_on_attach, client, bufnr)
				end

				local opts = { buffer = bufnr, silent = true, noremap = true }

				-- TypeScript-specific keymaps
				vim.keymap.set("n", "<leader>to", "<cmd>TSToolsOrganizeImports<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Organize Imports" }))
				vim.keymap.set("n", "<leader>ts", "<cmd>TSToolsSortImports<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Sort Imports" }))
				vim.keymap.set("n", "<leader>tu", "<cmd>TSToolsRemoveUnused<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Remove Unused Imports" }))
				vim.keymap.set("n", "<leader>tf", "<cmd>TSToolsFixAll<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Fix All" }))
				vim.keymap.set("n", "<leader>ta", "<cmd>TSToolsAddMissingImports<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Add Missing Imports" }))
				vim.keymap.set("n", "<leader>tg", "<cmd>TSToolsGoToSourceDefinition<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Go to Source Definition" }))
				vim.keymap.set("n", "<leader>tr", "<cmd>TSToolsRenameFile<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: Rename File" }))
				vim.keymap.set("n", "<leader>ti", "<cmd>TSToolsFileReferences<CR>", 
					vim.tbl_extend("force", opts, { desc = "TS: File References" }))

				-- Disable semantic tokens (can cause performance issues)
				-- Uncomment if you experience lag
				-- client.server_capabilities.semanticTokensProvider = nil
			end,
			capabilities = capabilities,
			settings = {
				-- Separate diagnostic server for better performance
				separate_diagnostic_server = true,
				
				-- Publish diagnostics on file open, change, and save
				publish_diagnostic_on = "insert_leave",
				
				-- Memory limit (increase if working with large projects)
				tsserver_max_memory = 8192,
				
				-- TypeScript server preferences
				tsserver_file_preferences = {
					-- Inlay hints (inline type annotations)
					includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,

					-- Import preferences
					includeCompletionsForModuleExports = true,
					quotePreference = "auto", -- "auto" | "double" | "single"
					
					-- Auto-import preferences
					includeCompletionsWithInsertText = true,
					includeAutomaticOptionalChainCompletions = true,
					includeCompletionsForImportStatements = true,
					includeCompletionsWithSnippetText = true,
					
					-- Allow incomplete completions
					allowIncompleteCompletions = true,
					allowRenameOfImportPath = true,
					
					-- Display preferences
					displayPartsForJSDoc = true,
					generateReturnInDocTemplate = true,
					
					-- Organiza imports preferences  
					organizeImportsIgnoreCase = "auto",
					organizeImportsCollation = "ordinal",
					organizeImportsNumericCollation = false,
					organizeImportsAccentCollation = true,
					organizeImportsCaseFirst = false,
				},
				
				-- TypeScript formatting options
				tsserver_format_options = {
					allowIncompleteCompletions = false,
					allowRenameOfImportPath = false,
					insertSpaceAfterCommaDelimiter = true,
					insertSpaceAfterConstructor = false,
					insertSpaceAfterSemicolonInForStatements = true,
					insertSpaceBeforeAndAfterBinaryOperators = true,
					insertSpaceAfterKeywordsInControlFlowStatements = true,
					insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
					insertSpaceBeforeFunctionParenthesis = false,
					insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
					insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
					insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
					insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
					insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
					insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
					insertSpaceAfterTypeAssertion = false,
					placeOpenBraceOnNewLineForFunctions = false,
					placeOpenBraceOnNewLineForControlBlocks = false,
					semicolons = "ignore", -- "ignore" | "insert" | "remove"
				},
				
				-- Completions settings
				complete_function_calls = true,
				include_completions_with_insert_text = true,
				
				-- Code lens (shows references, implementations above functions)
				code_lens = "off", -- "off" | "all" | "implementations_only" | "references_only"
				
				-- Disable built-in formatting (use prettier instead)
				disable_member_code_lens = true,
				
				-- Expose internal API for advanced usage
				expose_as_code_action = "all", -- "off" | "all"
			},
		}
	end,
}
