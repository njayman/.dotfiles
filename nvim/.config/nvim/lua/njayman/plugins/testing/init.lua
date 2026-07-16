return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-go",
		"rouge8/neotest-rust",
		"marilari88/neotest-vitest",
		"haydenmeade/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
					python = function()
						-- prefer local venv (uv creates .venv by default)
						local venv = vim.fn.getcwd() .. "/.venv/bin/python"
						if vim.fn.filereadable(venv) == 1 then
							return venv
						end
						return vim.fn.exepath("python3") or vim.fn.exepath("python")
					end,
				}),
				require("neotest-go"),
				require("neotest-rust"),
				require("neotest-vitest"),
				require("neotest-jest")({
					jestCommand = "npx jest",
				}),
			},
		})

		local nt = require("neotest")
		local map = function(key, fn, desc)
			vim.keymap.set("n", key, fn, { desc = "Test: " .. desc })
		end

		map("<leader>Tr", function()
			nt.run.run()
		end, "[R]un nearest")
		map("<leader>Tf", function()
			nt.run.run(vim.fn.expand("%"))
		end, "Run [F]ile")
		map("<leader>Ts", function()
			nt.summary.toggle()
		end, "[S]ummary panel")
		map("<leader>To", function()
			nt.output.open({ enter = true })
		end, "[O]utput")
		map("<leader>Ta", function()
			nt.run.run(vim.fn.getcwd())
		end, "Run [A]ll")
		map("<leader>Td", function()
			nt.run.run({ strategy = "dap" })
		end, "[D]ebug nearest")
		map("<leader>Tx", function()
			nt.run.stop()
		end, "Stop")
	end,
}
