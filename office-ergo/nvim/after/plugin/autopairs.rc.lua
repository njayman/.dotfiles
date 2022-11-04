local status, nvap = pcall(require, "nvim-autopairs")
if not status then
	return
end

nvap.setup({})
