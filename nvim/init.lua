-- =========================================
-- 🌿 Lazy.nvim Bootstrap
-- =========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================================
-- 🔧 General Settings
-- =========================================
vim.g.mapleader = " " -- Space as leader key
vim.g.maplocalleader = " "

-- Load core settings
require("core.options")

-- =========================================
-- ⚡ Lazy.nvim Setup
-- =========================================
require("lazy").setup("plugins", {
  defaults = {
    lazy = false,          -- Load plugins immediately by default
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
  },
  checker = { enabled = true }, -- auto-check plugin updates
  change_detection = {
    enabled = true,
    notify = false,
  },
})

-- =========================================
-- 🎹 Keymaps
-- =========================================
require("core.keymaps")

-- =========================================
-- 🧠 Autocommands
-- =========================================
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
  desc = "Highlight on yank",
})

-- Remove trailing whitespace before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
  desc = "Trim trailing whitespace",
})

-- Setup terminals for microservices (when u need to open multiple terminals)
require("terminals").setup_microservices()
