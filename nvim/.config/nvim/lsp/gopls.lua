---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "go.work", "go.mod", ".git" })
	end,
	single_file_support = true,
}
