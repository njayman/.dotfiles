local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		diagnostics_indicator = function(count)
			return "(" .. count .. ")"
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
			},
		},
	},
})

local map = vim.api.nvim_set_keymap

map("n", "gs", [[:BufferLinePick<CR>]], { noremap = true })
map("n", "<leader>b]", [[:BufferLineMoveNext<CR>]], { noremap = true })
map("n", "<leader>b[", [[:BufferLineMovePrev<CR>]], { noremap = true })
map("n", "<leader>be", [[:BufferLineSortByExtension<CR>]], { noremap = true })
map("n", "<leader>bd", [[:BufferLineSortByDirectory<CR>]], { noremap = true })
map("n", "<leader>bq", [[:BufferLinePickClose<CR>]], { noremap = true })
map("n", "<leader>blq", [[:BufferLineCloseLeft<CR>]], { noremap = true })
map("n", "<leader>brq", [[:BufferLineCloseRight<CR>]], { noremap = true })
map("n", "<leader>bs", [[:BufferLineTogglePin<CR>]], { noremap = true })
