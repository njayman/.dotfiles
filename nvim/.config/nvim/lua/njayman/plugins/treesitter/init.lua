return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"kevinhwang91/nvim-ufo",
			dependencies = { "kevinhwang91/promise-async" },
		},
	},
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"css",
			"dockerfile",
			"diff",
			"go",
			"html",
			"hyprlang",
			"java",
			"javascript",
			"json",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"sql",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true, disable = {} },
	},
	config = function(_, opts)
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})

		require("nvim-treesitter.configs").setup(opts)

		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
			open_fold_hl_timeout = 400,
			close_fold_kinds_for_ft = { default = {} },
			enable_get_fold_virt_text = false,
			preview = {
				win_config = {
					border = "rounded",
					winblend = 12,
					winhighlight = "Normal:Normal",
					maxheight = 20,
				},
				mappings = {
					scrollB = "",
					scrollF = "",
					scrollU = "",
					scrollD = "",
					scrollE = "<C-E>",
					scrollY = "<C-Y>",
					jumpTop = "",
					jumpBot = "",
					close = "q",
					switch = "<Tab>",
					trace = "<CR>",
				},
			},
		})

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}
