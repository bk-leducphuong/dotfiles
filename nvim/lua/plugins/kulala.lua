return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>k",
      kulala_keymaps_prefix = "",
      request_timeout = 10000,
      ui = {
        display_mode = "float",
        format_json_on_redirect = true,
      },
    },
  },
}
