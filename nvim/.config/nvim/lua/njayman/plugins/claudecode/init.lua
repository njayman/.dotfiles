return {
	"coder/claudecode.nvim",
	-- ponytail: native split, no snacks.nvim; add snacks as a dependency if you want its floating terminal
	opts = { terminal = { provider = "native", split_side = "right", split_width_percentage = 0.4 } },
	keys = {
		{ "<leader>Cc", "<cmd>ClaudeCode<cr>", desc = "Toggle [C]laude" },
		{ "<leader>Cf", "<cmd>ClaudeCodeFocus<cr>", desc = "[F]ocus Claude" },
		{ "<leader>Cr", "<cmd>ClaudeCode --resume<cr>", desc = "[R]esume Claude" },
		{ "<leader>CC", "<cmd>ClaudeCode --continue<cr>", desc = "[C]ontinue Claude" },
		{ "<leader>Cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select [M]odel" },
		{ "<leader>Cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current [B]uffer" },
		{ "<leader>Cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "[S]end selection" },
		{ "<leader>Cs", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file from oil", ft = "oil" },
		{ "<leader>Ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "[A]ccept diff" },
		{ "<leader>Cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "[D]eny diff" },
	},
}
