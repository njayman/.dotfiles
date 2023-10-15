local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	"stevearc/conform.nvim",
	"stevearc/dressing.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	{
		"williamboman/mason.nvim",
		run = ":MasonUpdate",
	},
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	"numToStr/Comment.nvim",
	"neovim/nvim-lspconfig",
	-- nvim cmp --
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lua",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	-- autopairs --
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},
	"dinhhuy258/git.nvim",
	"lewis6991/gitsigns.nvim",
	"mfussenegger/nvim-lint",
	{
		"mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
	},
	-- {
	--     'creativenull/efmls-configs-nvim', dependencies = { "neovim/nvim-lspconfig" }
	-- },
	{
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup()
		end,
	},
	"theprimeagen/harpoon",
	"uga-rosa/ccc.nvim",
}

local opts = {}

require("lazy").setup(plugins, opts)
