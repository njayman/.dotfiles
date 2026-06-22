---@type vim.lsp.Config
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "htmldjango" },
	root_markers = { "package.json", ".git" },
	single_file_support = true,
	init_options = {
		provideFormatter = false,
	},
}
