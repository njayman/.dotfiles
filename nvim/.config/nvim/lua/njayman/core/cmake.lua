local M = {}

local function find_root()
	local path = vim.fn.expand("%:p:h")
	local found = vim.fs.find("CMakeLists.txt", { upward = true, path = path })
	if found[1] then
		return vim.fs.dirname(found[1])
	end
	-- fallback to cwd
	local cwd_found = vim.fs.find("CMakeLists.txt", { path = vim.fn.getcwd() })
	if cwd_found[1] then
		return vim.fs.dirname(cwd_found[1])
	end
	return nil
end

local function symlink_compile_commands(root, build_dir)
	local src = build_dir .. "/compile_commands.json"
	local dst = root .. "/compile_commands.json"
	if vim.uv.fs_stat(src) then
		vim.uv.fs_unlink(dst)
		vim.uv.fs_symlink(src, dst)
	end
end

local function open_qf()
	local items = vim.fn.getqflist()
	if #items > 0 then
		vim.cmd("copen")
	end
end

local function run_job(cmd, cwd, on_done)
	vim.fn.setqflist({}, "r", { title = table.concat(cmd, " "), items = {} })
	vim.cmd("copen")

	local lines = {}

	vim.fn.jobstart(cmd, {
		cwd = cwd,
		stdout_buffered = false,
		stderr_buffered = false,
		on_stdout = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(lines, { text = line })
				end
			end
			vim.fn.setqflist({}, "a", { items = vim.tbl_map(function(l) return { text = l.text } end, lines) })
			vim.fn.setqflist({}, "a", { items = {} })
		end,
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(lines, { text = line })
				end
			end
			vim.schedule(function()
				vim.fn.setqflist({}, "a", { items = vim.tbl_map(function(l) return { text = l.text } end, lines) })
			end)
		end,
		on_exit = function(_, code)
			vim.schedule(function()
				if code == 0 then
					vim.notify("CMake: success", vim.log.levels.INFO)
				else
					vim.notify("CMake: failed (exit " .. code .. ")", vim.log.levels.ERROR)
					open_qf()
				end
				if on_done then
					on_done(code)
				end
			end)
		end,
	})
end

function M.configure()
	local root = find_root()
	if not root then
		vim.notify("CMakeLists.txt not found", vim.log.levels.ERROR)
		return
	end
	local build_dir = root .. "/build"
	run_job({ "cmake", "-B", build_dir, "-S", root, "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" }, root, function(code)
		if code == 0 then
			symlink_compile_commands(root, build_dir)
		end
	end)
end

function M.build()
	local root = find_root()
	if not root then
		vim.notify("CMakeLists.txt not found", vim.log.levels.ERROR)
		return
	end
	local build_dir = root .. "/build"

	local stat = vim.uv.fs_stat(build_dir .. "/CMakeCache.txt")
	if not stat then
		vim.notify("CMake: configuring first...", vim.log.levels.INFO)
		run_job({ "cmake", "-B", build_dir, "-S", root, "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" }, root, function(code)
			if code == 0 then
				symlink_compile_commands(root, build_dir)
				run_job({ "cmake", "--build", build_dir, "--parallel" }, root)
			end
		end)
	else
		run_job({ "cmake", "--build", build_dir, "--parallel" }, root)
	end
end

function M.clean()
	local root = find_root()
	if not root then
		vim.notify("CMakeLists.txt not found", vim.log.levels.ERROR)
		return
	end
	local build_dir = root .. "/build"
	run_job({ "cmake", "--build", build_dir, "--target", "clean" }, root)
end

function M.rebuild()
	local root = find_root()
	if not root then
		vim.notify("CMakeLists.txt not found", vim.log.levels.ERROR)
		return
	end
	local build_dir = root .. "/build"
	vim.fn.delete(build_dir, "rf")
	run_job({ "cmake", "-B", build_dir, "-S", root, "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" }, root, function(code)
		if code == 0 then
			symlink_compile_commands(root, build_dir)
			run_job({ "cmake", "--build", build_dir, "--parallel" }, root)
		end
	end)
end

return M
