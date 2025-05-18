return {
	"goolord/alpha-nvim",
	event = { "VimEnter" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		local header_nvim = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                  
      ]]
		local header_hello = [[

██╗  ██╗███████╗██╗     ██╗      ██████╗        ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗ ██╗
██║  ██║██╔════╝██║     ██║     ██╔═══██╗       ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗██║
███████║█████╗  ██║     ██║     ██║   ██║       ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║██║
██╔══██║██╔══╝  ██║     ██║     ██║   ██║       ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║╚═╝
██║  ██║███████╗███████╗███████╗╚██████╔╝▄█╗    ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝██╗
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝
                                                                                              
      ]]
		local header_kiss = [[

██╗  ██╗██╗███████╗███████╗
██║ ██╔╝██║██╔════╝██╔════╝
█████╔╝ ██║███████╗███████╗
██╔═██╗ ██║╚════██║╚════██║
██║  ██╗██║███████║███████║
╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
                           
  Keep it simple, stupid.
      ]]
		local header_etc = [[

███████╗████████╗ ██████╗██████╗ 
██╔════╝╚══██╔══╝██╔════╝╚════██╗
█████╗     ██║   ██║       ▄███╔╝
██╔══╝     ██║   ██║       ▀▀══╝ 
███████╗   ██║   ╚██████╗  ██╗   
╚══════╝   ╚═╝    ╚═════╝  ╚═╝   
                                 
      Easier to change?
      ]]
		local header_yagni = [[

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
		local headers = { header_nvim, header_hello, header_kiss, header_etc, header_yagni, header_zoi }
		math.randomseed(os.time())
		local random = math.random(1, #headers)

		dashboard.section.header.val = vim.split(headers[random], "\n")
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("l", "  Load Session", ":lua require('persisted').load()<CR>"),
			dashboard.button("e", "  Explore Files", ":Yazi<CR>"),
			dashboard.button(
				"f",
				"  Find Files",
				':lua require("telescope.builtin").find_files({ find_command = {"rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*", "--glob", "!**/target/*"} })<cr>'
			),
			dashboard.button("r", "󰡦  Find Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("p", "  Plugins", ":Lazy<CR>"),
			dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
		}
		require("alpha").setup(dashboard.config)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				dashboard.section.footer.val = "Loaded " .. stats.count .. " plugins in " .. stats.startuptime .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
