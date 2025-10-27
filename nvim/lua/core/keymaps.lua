local keymap = vim.keymap

-- General keymaps
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal width" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

-- Navigate between splits
-- keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
-- keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- Move lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Quick save all
keymap.set("n", "<leader>wa", ":wa<CR>", { desc = "Save all files" })

-- Close all buffers except current
keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close other buffers" })

-- Toggle word wrap
keymap.set("n", "<leader>uw", ":set wrap!<CR>", { desc = "Toggle word wrap" })

-- Toggle line numbers
keymap.set("n", "<leader>ul", ":set nu!<CR>", { desc = "Toggle line numbers" })

-- Toggle relative line numbers
keymap.set("n", "<leader>ur", ":set rnu!<CR>", { desc = "Toggle relative numbers" })

-- Move to beginning/end of line
keymap.set({ "n", "v" }, "H", "^", { desc = "Go to beginning of line" })
keymap.set({ "n", "v" }, "L", "$", { desc = "Go to end of line" })

-- Resize windows with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Quick fix list navigation
keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix" })
keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })

-- Location list navigation
keymap.set("n", "[l", ":lprev<CR>", { desc = "Previous location" })
keymap.set("n", "]l", ":lnext<CR>", { desc = "Next location" })
