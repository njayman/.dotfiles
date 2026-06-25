---@type vim.lsp.Config
return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = function(bufnr, cb)
		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then return cb(nil) end
		local root = vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json" })
		cb(root or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h"))
	end,
}
