local opt = vim.opt

opt.termguicolors = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 10
opt.sidescrolloff = 8

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

opt.synmaxcol = 300
opt.updatetime = 300
opt.redrawtime = 10000
opt.maxmempattern = 20000

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

opt.completeopt = "menu,menuone,noselect,popup"
vim.o.autocomplete = true
opt.cmdheight = 2
