require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "efm",
        "html",
        "tsserver",
        "jsonls",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "yamlls"
    }
})
