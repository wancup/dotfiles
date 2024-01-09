-- Colorscheme
return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				dim_inactive_windows = true,

				styles = {
					italic = false,
					transparency = true,
				},

				highlight_groups = {
					-- Treesitteer
					Keyword = { fg = "#7c9cee" }, -- Overwrap to increase contrast
					-- Noice
					NoiceCmdlinePopupBorder = { fg = "love" },
					NoiceCursor = { bg = "highlight_med" },
					-- Illuminate
					IlluminatedWordText = { bg = "love", blend = 20 },
					IlluminatedWordRead = { bg = "love", blend = 20 },
					IlluminatedWordWrite = { bg = "love", blend = 20 },
					-- Node.js Package Info
					PackageInfoOutdatedVersion = { fg = "love" },
					PackageInfoUpToDateVersion = { fg = "highlight_med" },
					-- Snipe Window
					SnipeWinLabel = { fg = "love" },
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
