---@type vim.lsp.Config
return {
	cmd = { "glsl_analyzer" },
	filetypes = { "glsl", "vert", "frag", "comp", "geom", "tesc", "tese" },
	root_markers = { ".git" },
	single_file_support = true,
}
