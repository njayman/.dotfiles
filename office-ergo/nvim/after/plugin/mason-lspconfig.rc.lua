local status, mlc = pcall(require, "mason-lspconfig")
if (not status) then return end

mlc.setup {
    ensure_installed = { "sumneko_lua", "pyright", "tsserver", "cssls", "bashls", "html", "jsonls", "marksman",
        "prismals", "sqlls", "rust_analyzer", "yamlls", "lemminx" }
}
