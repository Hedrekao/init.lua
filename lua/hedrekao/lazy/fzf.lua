return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			oldfiles = {
				include_current_session = true,
			},
			previewers = {
				builtin = {
					syntax_limit_b = 1024 * 100, -- 100KB
				},
			},
			keymap = {
				builtin = {
					["<C-j>"] = "down",
					["<C-k>"] = "up",
				},
				fzf = {
					["ctrl-j"] = "down",
					["ctrl-k"] = "up",
					["ctrl-q"] = "select-all+accept",
				},
			},
			files = {
				hidden = false,
				git_icons = false,
			},
			grep = {
				-- default ripgrep args; we’ll provide an “allow ignored” variant in a mapping
				rg_opts = table.concat({
					"--hidden",
					"--line-number",
					"--column",
					"--no-heading",
					"--color=never",
					"--smart-case",
				}, " "),
			},
		})

		-- Keymaps translated from your Telescope config

		-- <C-f> find_files with no_ignore = true (i.e., include ignored/untracked)
		-- In fzf-lua, use files with fd_opts/rg_opts toggles.
		vim.keymap.set("n", "<C-f>", function()
			-- Strategy 1: use fd and include ignored
			-- fd: include hidden + ignore .gitignore by adding -uu (twice) or -HI
			-- -H = include hidden, -I = no ignore files, -u = ignore VCS, -uu = really all
			fzf.files({
				fd_opts = [[--hidden --follow --color=never -uu]],
				-- If your setup uses ripgrep for listing, you can use:
				-- rg_opts = "--hidden --follow --no-ignore --color=never --smart-case"
			})
		end)

		-- <C-p> git_files
		vim.keymap.set("n", "<C-p>", function()
			-- falls back to files if not a git repo
			fzf.git_files()
		end)

		-- <leader>pws grep_string on <cword>
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			fzf.grep_cword({ search = word })
		end)

		-- <leader>pWs grep_string on <cWORD>
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			fzf.grep({ search = word })
		end)

		-- <leader>ps live_grep (default rg opts)
		-- vim.keymap.set("n", "<C-g>", function()
		-- 	fzf.live_grep()
		-- end)
		vim.keymap.set("n", "<C-g>", function()
			fzf.live_grep({
				rg_opts = table.concat({
					"--hidden", -- still search hidden files if not in dot-dirs
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--color=never",
					-- exclude all dot-directories
					"-g",
					"!.*/", -- exclude everything under any directory (baseline)
					"-g",
					"!.*/*", -- extra guard (ripgrep handles globs per path segment)
					"-g",
					"!.git",
					"-g",
					"!.*/**", -- ensure recursive exclusion of dot-dirs
					-- common heavy dirs (optional, remove if you don't want):
					"-g",
					"!node_modules",
					"-g",
					"!dist",
					"-g",
					"!build",
					"-g",
					"!.venv",
				}, " "),
			})
		end)

		-- <leader>pa live_grep including ignored files (Telescope vimgrep_arguments with -u)
		vim.keymap.set("n", "<leader>pa", function()
			-- replicate: rg --color=never --no-heading --with-filename --line-number --column --smart-case -u
			fzf.live_grep({
				rg_opts = table.concat({
					"--hidden",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--color=never",
					"-u",
				}, " "),
			})
		end)

		-- <leader>vh help_tags
		vim.keymap.set("n", "<leader>vh", function()
			fzf.help_tags()
		end)
	end,
}
