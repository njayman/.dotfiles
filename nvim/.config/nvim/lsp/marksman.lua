---@type vim.lsp.Config
return {
	cmd = { "marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { ".marksman.toml", ".git" })
	end,
	single_file_support = true,
}
