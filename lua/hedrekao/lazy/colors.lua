function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)
	local highlight_groups = {
		"Normal",
		"NormalNC",
		"NormalSB",
		"TroubleNormal",
		"TroubleNormalNC",
	}

	for _, group in ipairs(highlight_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end

	-- Set a subtle background for floating windows so they don't blend with transparent bg
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#32302f" })
	-- Set border colors for floating windows to be visible (no bg on border)
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#d5c4a1", bg = "none" })
	vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#d5c4a1", bg = "none" })
end

return {

	{
		"erikbackman/brightburn.vim",
	},

	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				contrast = "hard", -- Changed to "hard"
				transparent_mode = true,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = false },
					keywords = { italic = false },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.g.gruvbox_material_disable_italic_comment = 1

			ColorMyPencils("gruvbox-material")
		end,
	},
}
