return {
	"yetone/avante.nvim",
	enabled = true,
	event = "VeryLazy",
	build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
	opts = {
		provider = "groq",
		hints = { enabled = false },
		vendors = {
			groq = {
				endpoint = "https://api.groq.com/openai/v1/chat/completions",
				model = "llama-3.1-70b-versatile",
				api_key_name = "GROQ_API_KEY",
				parse_curl_args = function(opts, code_opts)
					return {
						url = opts.endpoint,
						headers = {
							["Accept"] = "application/json",
							["Content-Type"] = "application/json",
							["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
						},
						body = {
							model = opts.model,
							messages = { -- you can make your own message, but this is very advanced
								{ role = "system", content = code_opts.system_prompt },
								{
									role = "user",
									content = require("avante.providers.openai").get_user_message(code_opts),
								},
							},
							temperature = 0,
							max_tokens = 4096,
							stream = true, -- this will be set by default.
						},
					}
				end,
				parse_response_data = function(data_stream, event_state, opts)
					require("avante.providers").openai.parse_response(data_stream, event_state, opts)
				end,
			},
		},
		-- add any opts here
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
