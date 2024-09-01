local ok, err = pcall(require, "njayman")

local function loadDefaultConfig()
	vim.diagnostic.config()

	vim.opt.guicursor = ""

	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = true

	vim.opt.confirm = true

	vim.opt.smartindent = true

	vim.opt.swapfile = false
	vim.opt.backup = false
	vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
	vim.opt.undofile = true

	vim.opt.hlsearch = false
	vim.opt.incsearch = true

	vim.opt.termguicolors = true

	vim.opt.scrolloff = 8
	vim.opt.signcolumn = "yes"
	vim.opt.isfname:append("@-@")

	vim.opt.updatetime = 50

	vim.opt.colorcolumn = "80"
	vim.opt.completeopt = "menuone,noselect"

	vim.opt.wildmenu = true
	vim.opt.foldenable = true
	vim.opt.clipboard = "unnamedplus"
	vim.opt.background = "dark"

	vim.g.mapleader = " "

	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
end

if not ok then
	loadDefaultConfig()
	error(("Error loading config njayman. Switching to default"):format(err))
end
