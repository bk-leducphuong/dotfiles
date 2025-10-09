return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "ts_ls",
          "volar",
          "eslint",
          "html",
          "cssls",
          "tailwindcss",
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Safe wrapper so it doesn’t break if version changes
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({ capabilities = capabilities })
          end,
          ["volar"] = function()
            lspconfig.volar.setup({
              capabilities = capabilities,
              filetypes = { "vue" },
            })
          end,
          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              filetypes = {
                "javascript",
                "typescript",
                "typescriptreact",
                "javascriptreact",
              },
            })
          end,
        })
      else
        -- fallback for older mason-lspconfig
        for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
          lspconfig[server].setup({ capabilities = capabilities })
        end
      end

      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          local keymap = vim.keymap

          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
          keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
          keymap.set("n", "K", vim.lsp.buf.hover, opts)
          keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },
}

