local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation using Cmd+arrows (sent as M-H/J/K/L from Alacritty)
map("n", "<M-H>", "<C-w>h", { desc = "Go to left window", silent = true })
map("n", "<M-J>", "<C-w>j", { desc = "Go to lower window", silent = true })
map("n", "<M-K>", "<C-w>k", { desc = "Go to upper window", silent = true })
map("n", "<M-L>", "<C-w>l", { desc = "Go to right window", silent = true })

-- Buffer navigation (ctrl+shift+arrows)
map("n", "<C-S-Left>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "<C-S-Right>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<C-w>", ":bdelete<CR>", { desc = "Close buffer", silent = true })

-- New buffer (ctrl+t)
map("n", "<C-t>", ":enew<CR>", { desc = "New buffer", silent = true })

-- Window splits
map("n", "<M-\\>", ":vsplit<CR>", { desc = "Split vertically", silent = true })
map("n", "<M-->", ":split<CR>", { desc = "Split horizontally", silent = true })

