-- Package Info - Show package.json versions and update packages
return {
  "vuki656/package-info.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  event = "BufRead package.json",
  config = function()
    require("package-info").setup({
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>ns", "<cmd>lua require('package-info').show()<CR>", { desc = "Show package info", silent = true })
    vim.keymap.set("n", "<leader>nc", "<cmd>lua require('package-info').hide()<CR>", { desc = "Hide package info", silent = true })
    vim.keymap.set("n", "<leader>nt", "<cmd>lua require('package-info').toggle()<CR>", { desc = "Toggle package info", silent = true })
    vim.keymap.set("n", "<leader>nu", "<cmd>lua require('package-info').update()<CR>", { desc = "Update package", silent = true })
    vim.keymap.set("n", "<leader>nd", "<cmd>lua require('package-info').delete()<CR>", { desc = "Delete package", silent = true })
    vim.keymap.set("n", "<leader>ni", "<cmd>lua require('package-info').install()<CR>", { desc = "Install package", silent = true })
    vim.keymap.set("n", "<leader>np", "<cmd>lua require('package-info').change_version()<CR>", { desc = "Change package version", silent = true })
  end,
}
