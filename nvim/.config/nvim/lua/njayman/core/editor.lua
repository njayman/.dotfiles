local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = "//"
g.have_nerd_font = false

opt.number = true
opt.relativenumber = true
opt.mouse = "a"

vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

opt.breakindent = true
opt.undofile = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true

opt.signcolumn = "yes"

opt.updatetime = 250

opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.inccommand = "split"

opt.cursorline = true

opt.scrolloff = 10

opt.foldlevel = 99
opt.foldlevelstart = 99
