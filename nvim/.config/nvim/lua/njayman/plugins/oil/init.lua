return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = {
		{ "nvim-mini/mini.icons", opts = {} },
		"SirZenith/oil-vcs-status",
	},
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			win_options = {
				signcolumn = "yes:2",
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

		local status_const = require("oil-vcs-status.constant.status")
		local StatusType = status_const.StatusType

		require("oil-vcs-status").setup({
			status_symbol = {
				[StatusType.Added] = "",
				[StatusType.Copied] = "󰆏",
				[StatusType.Deleted] = "",
				[StatusType.Ignored] = "",
				[StatusType.Modified] = "",
				[StatusType.Renamed] = "",
				[StatusType.TypeChanged] = "󰉺",
				[StatusType.Unmodified] = " ",
				[StatusType.Unmerged] = "",
				[StatusType.Untracked] = "",
				[StatusType.External] = "",

				[StatusType.UpstreamAdded] = "󰈞",
				[StatusType.UpstreamCopied] = "󰈢",
				[StatusType.UpstreamDeleted] = "",
				[StatusType.UpstreamIgnored] = " ",
				[StatusType.UpstreamModified] = "󰏫",
				[StatusType.UpstreamRenamed] = "",
				[StatusType.UpstreamTypeChanged] = "󱧶",
				[StatusType.UpstreamUnmodified] = " ",
				[StatusType.UpstreamUnmerged] = "",
				[StatusType.UpstreamUntracked] = " ",
				[StatusType.UpstreamExternal] = "",
			},
		})
	end,
}
