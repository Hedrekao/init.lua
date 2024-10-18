return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			python = { "autopep8" },
			lua = { "stylua" },
			go = { "gofmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
}
