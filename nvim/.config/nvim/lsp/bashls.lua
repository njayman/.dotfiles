---@type vim.lsp.Config
return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd()
	end,
	single_file_support = true,
}
