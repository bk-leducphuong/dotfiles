-- ~/.config/nvim/lua/plugins/lsp.lua
return {
	-- Mason (LSP installer)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls", -- TypeScript/JavaScript
          "vls", -- Vue 2
					"vue_ls", -- Vue 3
					"eslint", -- ESLint
					"html", -- HTML
					"cssls", -- CSS
					"tailwindcss", -- Tailwind
					"jsonls", -- JSON
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
			"b0o/schemastore.nvim", -- JSON schemas
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
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end	

			local lspconfig = require("lspconfig")
			-- 🛠️ 1. Define the 'on_attach' function to set keymaps when a server attaches.
			-- This is the new, recommended way to set LSP keymaps.
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true, noremap = true }
				local keymap = vim.keymap

				-- Set your keymaps here, using the 'opts' table
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

         -- Additional diagnostic keymaps
        keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Diagnostics location list" })
        keymap.set("n", "<leader>dq", "<cmd>lua vim.diagnostic.setqflist()<CR>", { desc = "Diagnostics quickfix list" })	keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end

			-- 🤝 2. Get LSP capabilities from nvim-cmp.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- 📦 3. Set up mason and mason-lspconfig.
			require("mason").setup()

			local servers = {
				"ts_ls",
				"volar",
				"eslint",
				"html",
				"cssls",
				"tailwindcss",
				"jsonls",
			}
			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})

			-- ⚙️ 4. Define server-specific configurations.
			local server_configs = {
				-- Vue
				volar = {
					filetypes = { "vue" },
				},
				-- TypeScript / JavaScript
				ts_ls = {
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
					root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
				},
				-- JSON with schema support
				jsonls = {
					filetypes = { "json", "jsonc" },
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
			}

			-- 🚀 5. Loop through servers and configure them.
			for _, server_name in ipairs(servers) do
				-- Manually load server configuration to avoid deprecated "framework"
				local server_config_ok, server_config =
					pcall(require, "lspconfig.server_configurations." .. server_name)
				if server_config_ok then
					rawset(lspconfig, server_name, server_config)
					-- Start with the base configuration for all servers
					local base_config = {
						on_attach = on_attach,
						capabilities = capabilities,
					}

					-- Get the server-specific settings, if any
					local server_specific_config = server_configs[server_name] or {}

					-- Merge the base and server-specific settings
					local final_config = vim.tbl_deep_extend("force", base_config, server_specific_config)

					-- Setup the server with the final configuration
					lspconfig[server_name].setup(final_config)
				end
			end
		end,
	},
}
