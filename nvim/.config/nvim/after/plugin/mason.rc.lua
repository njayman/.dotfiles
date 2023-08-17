require "mason".setup {}
require "mason-lspconfig".setup {
    ensure_installed = {
        "bashls",
        "dockerls",
        "docker_compose_language_service",
        "efm",
        "emmet_language_server",
        "eslint",
        "tsserver",
        "jsonls",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "yamlls",
    }
}
