return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          vue = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        conform.format({ lsp_fallback = true, timeout_ms = 500 })
      end, { desc = "Format file or range" })
    end,
  },
}

