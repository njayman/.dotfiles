return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

		-- Python (debugpy via Mason or uv)
		local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
		local uv_debugpy = vim.fn.expand("~/.local/share/uv/tools/debugpy/bin/python")
		local python_path = vim.fn.filereadable(mason_debugpy) == 1 and mason_debugpy
			or vim.fn.filereadable(uv_debugpy) == 1 and uv_debugpy
			or vim.fn.exepath("python3")
		require("dap-python").setup(python_path)

		-- Go (delve)
		require("dap-go").setup()

		-- C / C++ / Rust (codelldb via Mason)
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		local codelldb_config = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				name = "Attach",
				type = "codelldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.c = codelldb_config
		dap.configurations.cpp = codelldb_config
		dap.configurations.rust = codelldb_config

		-- JS / TS / Node (vscode-js-debug via Mason, if available)
		local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
		if vim.fn.filereadable(js_debug) == 1 then
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug, "${port}" },
				},
			}

			local js_config = {
				{
					name = "Launch Node",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
				},
				{
					name = "Attach Node",
					type = "pwa-node",
					request = "attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
				},
			}

			for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
				dap.configurations[ft] = js_config
			end
		end

		-- Keybinds
		local map = function(key, fn, desc)
			vim.keymap.set("n", key, fn, { desc = "DAP: " .. desc })
		end

		map("<leader>db", dap.toggle_breakpoint, "Toggle [B]reakpoint")
		map("<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Condition: "))
		end, "Conditional [B]reakpoint")
		map("<leader>dc", dap.continue, "[C]ontinue / Start")
		map("<leader>dn", dap.step_over, "Step [N]ext (over)")
		map("<leader>di", dap.step_into, "Step [I]nto")
		map("<leader>do", dap.step_out, "Step [O]ut")
		map("<leader>dr", dap.repl.open, "Open [R]EPL")
		map("<leader>dl", dap.run_last, "Run [L]ast")
		map("<leader>du", dapui.toggle, "Toggle [U]I")
		map("<leader>dx", dap.terminate, "Terminate")
	end,
}
