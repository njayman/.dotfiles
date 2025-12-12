local M = {}

M.state = {
	terms = {}, -- { bufnr = number }
	current = nil, -- index into terms
	view = nil, -- "float" | "tab" | "bottom"
	winids = {}, -- active windows
}

local function lock_terminal(buf)
	vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
end

local function spawn_terminal(buf)
	vim.api.nvim_set_current_buf(buf)
	vim.fn.jobstart(vim.o.shell, {
		term = true,
		cwd = vim.fn.getcwd(),
	})
end

local function new_term()
	local buf = vim.api.nvim_create_buf(false, true)

	lock_terminal(buf)
	spawn_terminal(buf)

	table.insert(M.state.terms, { bufnr = buf })
	M.state.current = #M.state.terms
	return buf
end

local function current_buf()
	local idx = M.state.current
	if idx and M.state.terms[idx] then
		local buf = M.state.terms[idx].bufnr
		if vim.api.nvim_buf_is_valid(buf) then
			return buf
		end
	end
	return new_term()
end

function M.close_view()
	for _, win in ipairs(M.state.winids) do
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end
	M.state.winids = {}
	M.state.view = nil
end

function M.toggle_float()
	if M.state.view == "float" then
		return M.close_view()
	end

	M.close_view()
	M.state.view = "float"

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)

	local win = vim.api.nvim_open_win(current_buf(), true, {
		relative = "editor",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		border = "rounded",
	})

	M.state.winids = { win }
end

function M.toggle_tab()
	if M.state.view == "tab" then
		return M.close_view()
	end

	M.close_view()
	M.state.view = "tab"

	vim.cmd("tabnew")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, current_buf())

	M.state.winids = { win }
end

function M.toggle_bottom()
	if M.state.view == "bottom" then
		return M.close_view()
	end

	M.close_view()
	M.state.view = "bottom"

	vim.cmd("botright split")
	vim.cmd("resize 15")

	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, current_buf())

	M.state.winids = { win }
end

return M
