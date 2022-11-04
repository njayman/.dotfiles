local status, mlc = pcall(require, "mason-lspconfig")
if not status then
	return
end
local servers = {
	"bashls",
	"clangd",
	"cssls",
	"html",
	"jsonls",
	"lemminx",
	"sumneko_lua",
	"marksman",
	"prismals",
	"pyright",
	"rust_analyzer",
	"sqlls",
	"tsserver",
	"lemminx",
	"yamlls",
}

mlc.setup({
	ensure_installed = servers,
})
