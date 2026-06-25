local M = {}

local tools = {
	{
		category = "LSP",
		entries = {
			{ cmd = "clangd",                        label = "clangd (C/C++)" },
			{ cmd = "lua-language-server",           label = "lua-language-server (Lua)" },
			{ cmd = "typescript-language-server",    label = "typescript-language-server (TS/JS)" },
			{ cmd = "ty",                            label = "ty (Python types)" },
			{ cmd = "ruff",                          label = "ruff (Python lint/format)" },
			{ cmd = "rust-analyzer",                 label = "rust-analyzer (Rust)" },
			{ cmd = "gopls",                         label = "gopls (Go)" },
			{ cmd = "bash-language-server",          label = "bash-language-server (Bash)" },
			{ cmd = "biome",                         label = "biome (JS/TS)" },
			{ cmd = "deno",                          label = "deno (Deno)" },
			{ cmd = "marksman",                      label = "marksman (Markdown)" },
			{ cmd = "cmake-language-server",         label = "cmake-language-server (CMake)" },
			{ cmd = "glsl_analyzer",                 label = "glsl_analyzer (GLSL)" },
			{ cmd = "docker-langserver",             label = "docker-langserver (Dockerfile)" },
			{ cmd = "vscode-css-language-server",    label = "vscode-css-language-server (CSS)" },
			{ cmd = "vscode-html-language-server",   label = "vscode-html-language-server (HTML)" },
		},
	},
	{
		category = "Formatters",
		entries = {
			{ cmd = "stylua",       label = "stylua (Lua)" },
			{ cmd = "ruff",         label = "ruff format (Python)" },
			{ cmd = "gofmt",        label = "gofmt (Go)" },
			{ cmd = "shfmt",        label = "shfmt (Bash/Shell)" },
			{ cmd = "clang-format", label = "clang-format (C/C++)" },
			{ cmd = "rustfmt",      label = "rustfmt (Rust)" },
			{ cmd = "prettier",     label = "prettier (JS/TS/HTML/CSS fallback)" },
		},
	},
	{
		category = "Linters",
		entries = {
			{ cmd = "selene",          label = "selene (Lua)" },
			{ cmd = "clang-tidy",      label = "clang-tidy (C/C++)" },
			{ cmd = "staticcheck",     label = "staticcheck (Go)" },
			{ cmd = "shellcheck",      label = "shellcheck (Bash/Shell)" },
			{ cmd = "hadolint",        label = "hadolint (Dockerfile)" },
			{ cmd = "eslint",          label = "eslint (JS/TS fallback)" },
			{ cmd = "markdownlint",    label = "markdownlint (Markdown)" },
		},
	},
	{
		category = "DAP Adapters",
		entries = {
			{ cmd = "python3",   label = "python3 (debugpy runtime)" },
			{ cmd = "dlv",       label = "dlv / delve (Go)" },
			{ cmd = "codelldb",  label = "codelldb (C/C++/Rust)" },
			{ cmd = "node",      label = "node (JS/TS debug)" },
		},
	},
	{
		category = "Test Tools",
		entries = {
			{ cmd = "pytest",  label = "pytest (Python)" },
			{ cmd = "dlv",     label = "dlv (Go test debug)" },
			{ cmd = "cargo",   label = "cargo (Rust tests)" },
			{ cmd = "node",    label = "node (JS/TS tests)" },
		},
	},
	{
		category = "Build",
		entries = {
			{ cmd = "cmake",  label = "cmake" },
			{ cmd = "make",   label = "make" },
			{ cmd = "ninja",  label = "ninja" },
			{ cmd = "cargo",  label = "cargo (Rust)" },
			{ cmd = "go",     label = "go" },
		},
	},
}

function M.check()
	for _, group in ipairs(tools) do
		vim.health.start(group.category)
		for _, tool in ipairs(group.entries) do
			if vim.fn.executable(tool.cmd) == 1 then
				vim.health.ok(tool.label)
			else
				vim.health.warn(tool.label .. " not found", { "Install: " .. tool.cmd })
			end
		end
	end
end

return M
