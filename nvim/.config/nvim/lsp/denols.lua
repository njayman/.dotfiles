---@type vim.lsp.Config
return {
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
	end,
	single_file_support = false,
}
