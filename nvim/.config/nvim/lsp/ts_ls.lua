---@type vim.lsp.Config
return {
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "package.json", "tsconfig.json" })
	end,
	single_file_support = false,
}
