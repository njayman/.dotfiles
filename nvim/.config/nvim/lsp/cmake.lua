---@type vim.lsp.Config
return {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "CMakePresets.json", "CTestTestfile.cmake", ".git" })
	end,
	init_options = { buildDirectory = "build" },
	single_file_support = true,
}
