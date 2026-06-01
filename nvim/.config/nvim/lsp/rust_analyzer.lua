---@type vim.lsp.Config
return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "Cargo.toml", "Cargo.lock", ".git" })
	end,
	single_file_support = true,
}
