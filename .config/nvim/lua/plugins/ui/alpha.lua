-- Startup
return {
	{
		"goolord/alpha-nvim",
		event = { "VimEnter" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local header1 = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                  
      ]]
			local header2 = [[

██╗  ██╗███████╗██╗     ██╗      ██████╗        ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗ ██╗
██║  ██║██╔════╝██║     ██║     ██╔═══██╗       ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗██║
███████║█████╗  ██║     ██║     ██║   ██║       ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║██║
██╔══██║██╔══╝  ██║     ██║     ██║   ██║       ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║╚═╝
██║  ██║███████╗███████╗███████╗╚██████╔╝▄█╗    ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝██╗
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝
                                                                                              
      ]]
			local header3 = [[

██╗  ██╗██╗███████╗███████╗
██║ ██╔╝██║██╔════╝██╔════╝
█████╔╝ ██║███████╗███████╗
██╔═██╗ ██║╚════██║╚════██║
██║  ██╗██║███████║███████║
╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
                           
  Keep it simple, stupid.
      ]]
			local header4 = [[

███████╗████████╗ ██████╗██████╗ 
██╔════╝╚══██╔══╝██╔════╝╚════██╗
█████╗     ██║   ██║       ▄███╔╝
██╔══╝     ██║   ██║       ▀▀══╝ 
███████╗   ██║   ╚██████╗  ██╗   
╚══════╝   ╚═╝    ╚═════╝  ╚═╝   
                                 
      Easier to change?
      ]]
			local header5 = [[

██╗   ██╗ █████╗  ██████╗ ███╗   ██╗██╗
╚██╗ ██╔╝██╔══██╗██╔════╝ ████╗  ██║██║
 ╚████╔╝ ███████║██║  ███╗██╔██╗ ██║██║
  ╚██╔╝  ██╔══██║██║   ██║██║╚██╗██║██║
   ██║   ██║  ██║╚██████╔╝██║ ╚████║██║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝

        You ain't gonna need it
      ]]

			local header_zoi = [[

 ███████╗ ██████╗ ██╗
 ╚══███╔╝██╔═══██╗██║
   ███╔╝ ██║   ██║██║
  ███╔╝  ██║   ██║██║
 ███████╗╚██████╔╝██║
 ╚══════╝ ╚═════╝ ╚═╝

Zero One Infinity rule
      ]]
			local headers = { header1, header2, header3, header4, header5, header_zoi }
			math.randomseed(os.time())
			local random = math.random(1, #headers)

			dashboard.section.header.val = vim.split(headers[random], "\n")
			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("l", "  Load Session", ":lua require('persisted').load()<CR>"),
				dashboard.button("f", "  Find Files", ":Telescope find_files<CR>"),
				dashboard.button("r", "󰡦  Find Recent Files", ":Telescope oldfiles<CR>"),
				dashboard.button("p", "  Plugins", ":Lazy<CR>"),
				dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
			}
			require("alpha").setup(dashboard.config)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					dashboard.section.footer.val = "Loaded "
						.. stats.count
						.. " plugins in "
						.. stats.startuptime
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
