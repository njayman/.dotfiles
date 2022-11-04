local status, mst = pcall(require, "mason-tool-installer")
if (not status) then return end

local tools = { "black", "eslint_d", "prettierd", "markdownlint", "pylint", "yamlfmt", "stylua" }

mst.setup {
    ensure_installed = tools
}
