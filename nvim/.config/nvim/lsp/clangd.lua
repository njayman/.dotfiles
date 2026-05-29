---@type vim.lsp.Config
return {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "compile_commands.json", "compile_flags.txt", ".git" })
	end,
}
