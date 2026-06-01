---@type vim.lsp.Config
return {
	cmd = { "glsl_analyzer" },
	filetypes = { "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd()
	end,
	single_file_support = true,
}
