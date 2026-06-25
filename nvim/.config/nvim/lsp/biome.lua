---@type vim.lsp.Config
return {
	cmd = { "biome", "lsp-proxy" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "json", "jsonc", "css" },
	root_markers = { "biome.json", "biome.jsonc" },
	single_file_support = false,
}
