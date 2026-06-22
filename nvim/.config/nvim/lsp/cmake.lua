---@type vim.lsp.Config
return {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	root_markers = { "CMakePresets.json", "CTestTestfile.cmake", "CMakeLists.txt", ".git" },
	init_options = { buildDirectory = "build" },
	single_file_support = true,
}
