local status, rext = pcall(require, "react-extract")
if not status then
	return
end

rext.setup()

vim.keymap.set({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file)
vim.keymap.set({ "v" }, "<Leader>rc", require("react-extract").extract_to_current_file)
