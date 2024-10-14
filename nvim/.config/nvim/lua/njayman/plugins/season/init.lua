return {
	"njayman/season.nvim",
	config = function()
		require("season").setup({
			show_notifications = true,
		})

		vim.keymap.set("n", "<leader>ss", function()
			require("season").save_session()
		end, { desc = "Save Session" })
		vim.keymap.set("n", "<leader>sl", function()
			require("season").load_session()
		end, { desc = "Load Session" })
	end,
}
