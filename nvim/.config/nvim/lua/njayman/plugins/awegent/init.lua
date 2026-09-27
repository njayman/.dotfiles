return {
	dir = vim.fn.expand("~/Development/oss/awegent"),
	name = "awegent",
	config = function()
		require("awegent").setup({
			active = {
				provider = "claude", -- uses the `claude` CLI's own Pro/Max login, no API key needed
				mode = "build",
			},
			-- one example skill so "<leader>ak" / "/review" has something to
			-- invoke out of the box; add more here as you find uses for them
			skills = {
				review = "Review the referenced code for bugs, unclear naming, and missed edge cases. Be terse.",
			},
		})

		local awegent = require("awegent")

		vim.keymap.set("n", "<leader>ac", awegent.open_chat, { desc = "[C]hat" })
		vim.keymap.set("n", "<leader>as", awegent.toggle_sidebar, { desc = "[S]idebar toggle" })
		vim.keymap.set("n", "<leader>an", awegent.new_chat, { desc = "[N]ew chat" })
		vim.keymap.set("n", "<leader>ab", awegent.branch_chat, { desc = "[B]ranch session" })
		vim.keymap.set("n", "<leader>az", awegent.compact, { desc = "Summari[z]e/compact history" })
		vim.keymap.set("n", "<leader>aS", awegent.pick_session, { desc = "[S]essions (resume)" })
		vim.keymap.set("n", "<leader>ap", awegent.pick_provider, { desc = "[P]rovider" })
		vim.keymap.set("n", "<leader>am", awegent.pick_model, { desc = "[M]odel" })
		vim.keymap.set("n", "<leader>ae", awegent.pick_effort, { desc = "[E]ffort" })
		vim.keymap.set("n", "<leader>ad", awegent.pick_mode, { desc = "mo[D]e (plan/build/auto)" })
		vim.keymap.set("n", "<leader>aD", awegent.cycle_mode, { desc = "Cycle mo[D]e, no picker" })
		vim.keymap.set("n", "<leader>af", awegent.add_file, { desc = "[F]ile/dir @-tag" })
		vim.keymap.set("n", "<leader>ak", awegent.skill, { desc = "S[k]ill /-invoke" })
		vim.keymap.set("n", "<leader>ag", awegent.spawn_agent, { desc = "Spawn a[g]ent" })
		vim.keymap.set("n", "<leader>aG", awegent.pick_agents, { desc = "List/focus a[G]ents" })

		vim.keymap.set("n", "<leader>a]", "<cmd>AwegentNextChange<CR>", { desc = "Next changed hunk" })
		vim.keymap.set("n", "<leader>a[", "<cmd>AwegentPrevChange<CR>", { desc = "Prev changed hunk" })
		vim.keymap.set("n", "<leader>aX", "<cmd>AwegentClearChanges<CR>", { desc = "Clear change highlights" })
	end,
}
