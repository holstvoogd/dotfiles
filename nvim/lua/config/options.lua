local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.completeopt = "menu,menuone,noselect"
opt.termguicolors = true

-- UI
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.signcolumn = "yes"
opt.cursorline = true
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8

-- Tabs & Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

