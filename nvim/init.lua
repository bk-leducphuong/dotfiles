-- ~/.config/nvim/init.lua
-- (No changes needed, this file is correct)

-- Bootstrap lazy.nvim
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

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load plugins from the `lua/plugins` directory
require("lazy").setup("plugins", {
	rocks = {
		enabled = false,
	},
})

-- Load core settings
require("core.options")
require("core.keymaps")
