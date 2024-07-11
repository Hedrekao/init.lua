return {
	{
		"folke/trouble.nvim",
		opts = { auto_close = true }, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"t]",
				"<cmd>Trouble next jump=true<cr>",
				desc = "Next Trouble",
			},
			{
				"t[",
				"<cmd>Trouble prev jump=true<cr>",
				desc = "Previous Trouble",
			},
		},
		icons = {
			indent = {
				middle = " ",
				last = " ",
				top = " ",
				ws = "│  ",
			},
		},
		modes = {
			test = {
				mode = "diagnostics",
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
		},
	},
}
