---@type vim.lsp.Config
return {
	cmd = { "deno", "lsp" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = function(bufnr, cb)
		cb(vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }))
	end,
}
