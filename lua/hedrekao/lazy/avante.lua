return {
	"yetone/avante.nvim",
	enabled = false,
	event = "VeryLazy",
	build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
	opts = {
		-- add any opts here
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
