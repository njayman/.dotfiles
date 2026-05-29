---@type vim.lsp.Config
return {
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "biome.json", "biome.jsonc" })
	end,
	single_file_support = false,
}
