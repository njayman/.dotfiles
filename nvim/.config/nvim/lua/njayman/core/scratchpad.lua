local M = {}

-- ponytail: one global scratch file, per-project scratch if ever needed
M.path = vim.fn.stdpath("data") .. "/scratchpad.md"

local win = nil

function M.toggle()
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, false)
		win = nil
		return
	end

	vim.fn.mkdir(vim.fs.dirname(M.path), "p")
	local buf = vim.fn.bufadd(M.path)
	vim.fn.bufload(buf)
	vim.bo[buf].buflisted = false
	vim.bo[buf].bufhidden = "hide"

	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)

	win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		border = "rounded",
		title = " scratchpad ",
		title_pos = "center",
	})

	-- autosave whenever the scratchpad is left or hidden
	vim.api.nvim_create_autocmd({ "BufLeave", "BufHidden" }, {
		buffer = buf,
		group = vim.api.nvim_create_augroup("njayman_scratchpad", { clear = true }),
		callback = function()
			if vim.bo[buf].modified then
				vim.api.nvim_buf_call(buf, function()
					vim.cmd("silent! write")
				end)
			end
		end,
	})
	vim.keymap.set("n", "q", M.toggle, { buffer = buf, desc = "Close scratchpad" })
end

return M
