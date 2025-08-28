return {
	"copypaster",
	enabled = false,
	dir = "~/code/copypaster",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		local copypaster = require("copypaster")
		vim.keymap.set("n", "<leader>lm", copypaster.pick_llm_context, { desc = "Pick llm context" })
	end,
}
