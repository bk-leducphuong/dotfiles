-- TypeScript via typescript-tools.nvim; disable LazyVim's vtsls/tsserver/ts_ls/tsgo for JS/TS buffers
return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities({
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
              resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" },
              },
            },
          },
        },
      })

      return {
        on_attach = function(_, bufnr)
          local o = { buffer = bufnr, silent = true, noremap = true }

          vim.keymap.set(
            "n",
            "<leader>to",
            "<cmd>TSToolsOrganizeImports<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Organize Imports" })
          )
          vim.keymap.set(
            "n",
            "<leader>ts",
            "<cmd>TSToolsSortImports<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Sort Imports" })
          )
          vim.keymap.set(
            "n",
            "<leader>tu",
            "<cmd>TSToolsRemoveUnused<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Remove Unused Imports" })
          )
          vim.keymap.set(
            "n",
            "<leader>tf",
            "<cmd>TSToolsFixAll<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Fix All" })
          )
          vim.keymap.set(
            "n",
            "<leader>ta",
            "<cmd>TSToolsAddMissingImports<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Add Missing Imports" })
          )
          vim.keymap.set(
            "n",
            "<leader>tg",
            "<cmd>TSToolsGoToSourceDefinition<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Go to Source Definition" })
          )
          vim.keymap.set(
            "n",
            "<leader>tr",
            "<cmd>TSToolsRenameFile<CR>",
            vim.tbl_extend("force", o, { desc = "TS: Rename File" })
          )
          vim.keymap.set(
            "n",
            "<leader>ti",
            "<cmd>TSToolsFileReferences<CR>",
            vim.tbl_extend("force", o, { desc = "TS: File References" })
          )
        end,
        capabilities = capabilities,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          tsserver_max_memory = 8192,
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
            includeCompletionsWithInsertText = true,
            includeAutomaticOptionalChainCompletions = true,
            includeCompletionsForImportStatements = true,
            includeCompletionsWithSnippetText = true,
            allowIncompleteCompletions = true,
            allowRenameOfImportPath = true,
            displayPartsForJSDoc = true,
            generateReturnInDocTemplate = true,
            organizeImportsIgnoreCase = "auto",
            organizeImportsCollation = "ordinal",
            organizeImportsNumericCollation = false,
            organizeImportsAccentCollation = true,
            organizeImportsCaseFirst = false,
          },
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
            semicolons = "ignore",
          },
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          code_lens = "off",
          disable_member_code_lens = true,
          expose_as_code_action = "all",
        },
      }
    end,
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      for _, name in ipairs({ "vtsls", "tsserver", "ts_ls", "tsgo" }) do
        local s = opts.servers[name]
        if type(s) == "table" then
          s.enabled = false
        else
          opts.servers[name] = { enabled = false }
        end
      end
    end,
  },
}
