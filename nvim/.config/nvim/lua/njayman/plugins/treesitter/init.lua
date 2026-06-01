return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"kevinhwang91/nvim-ufo",
			dependencies = { "kevinhwang91/promise-async" },
		},
	},
	config = function()
		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			extension = {
				vert = "glsl",
				frag = "glsl",
				comp = "glsl",
				geom = "glsl",
				tesc = "glsl",
				tese = "glsl",
				glsl = "glsl",
			},
		})

		require("nvim-treesitter").install({
			"bash", "c", "cmake", "cpp", "css", "dockerfile", "diff",
			"glsl", "go", "html", "hyprlang", "java", "javascript",
			"json", "lua", "luadoc", "markdown", "markdown_inline",
			"python", "rust", "sql", "typescript", "vim", "vimdoc", "yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("njayman-treesitter", { clear = true }),
			callback = function()
				if pcall(vim.treesitter.start) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

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
	end,
}
