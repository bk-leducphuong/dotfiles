-- lua/plugins/formatter.lua

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Run on save
  cmd = { "ConformInfo" },
  opts = {
    -- Map filetypes to formatters
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
    },
    -- Define custom prettier options
      formatters = {
        prettier = {
          prepend_args = {
            "--no-semi",
            "--trailing-comma=none",
            "--single-quote=true",
            "--print-width=80",
            "--tab-width=2",
            "--use-tabs=false",
          },
        },
      },
    -- Set up format-on-save
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true, -- Fallback to LSP formatting if conform fails
    },
  },
  init = function()
    -- Add a keymap for manual formatting
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format file or range" })
  end,
}
