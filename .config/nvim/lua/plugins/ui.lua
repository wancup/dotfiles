return {
	-- Startup
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
			local headers = { header1, header2, header3, header4, header5 }
			math.randomseed(os.time())
			local random = math.random(1, #headers)

			dashboard.section.header.val = vim.split(headers[random], "\n")
			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("l", "  Load Session", ":lua require('persisted').load()<CR>"),
				dashboard.button("f", "  Find Files", ":Telescope find_files<CR>"),
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

	-- Status Line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "VeryLazy" },
		opts = {
			options = { theme = "rose-pine" },
			sections = {
				lualine_a = {
					{
						"mode",
						cond = function()
							return not package.loaded["noice"] or not require("noice").api.status.mode.has()
						end,
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "filesize" },
				lualine_z = { "progress", "location" },
			},
		},
	},

	-- File Tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree reveal toggle<cr>", desc = "[E]xplore files" },
			{ "<leader>ge", "<cmd>Neotree reveal toggle git_status float<cr>", desc = "[G]it [E]xplore files" },
		},
		opts = {
			close_if_last_window = true,
			window = {
				mappings = {
					["<C-j>"] = "open",
					["<space>"] = false,
					["<"] = false,
					[">"] = false,
				},
				width = 30,
			},
			filesystem = {
				window = {
					mappings = {
						["<leader>ff"] = "find_files_in_dir",
						["<leader>fl"] = "live_grep_in_dir",
						["Y"] = "copy_file_name",
					},
				},
				commands = {
					find_files_in_dir = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").find_files({ search_dirs = { path } })
					end,
					live_grep_in_dir = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").live_grep({ search_dirs = { path } })
					end,
					copy_file_name = function(state)
						local node = state.tree:get_node()
						vim.fn.setreg(vim.v.register, node.name)
					end,
				},
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		},
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader><S-h>", "<Cmd>BufferLineCyclePrev<CR>" },
			{ "<leader><S-l>", "<Cmd>BufferLineCycleNext<CR>" },
			{ "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "[B]uffer [P]ick" },
			{ "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "[B]uffer Pick [C]lose" },
			{ "<leader>bt", "<Cmd>BufferLineTogglePin<CR>", desc = "[B]uffer [T]oggle Pin" },
			{ "<leader>bH", "<Cmd>BufferLineCloseLeft<CR>", desc = "[B]uffer Close Left" },
			{ "<leader>bL", "<Cmd>BufferLineCloseRight<CR>", desc = "[B]uffer Close Right" },
			{ "<leader>bO", "<Cmd>BufferLineCloseOthers<CR>", desc = "[B]uffer Close [O]thers" },
			{ "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", desc = "[B]uffer Move Left" },
			{ "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", desc = "[B]uffer Move Right" },
		},
		opts = {
			options = {
				always_show_bufferline = false,
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
					},
				},
			},
		},
	},

	-- Which Key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "Goto" },
				["<leader>b"] = { name = "Buffer" },
				["<leader>d"] = { name = "Diagnostics" },
				["<leader>f"] = { name = "Find" },
				["<leader>fg"] = { name = "Find Git" },
				["<leader>g"] = { name = "Git" },
				["<leader>gh"] = { name = "Git Hunk" },
				["<leader>gb"] = { name = "Git Buffer" },
				["<leader>l"] = { name = "Lazygit" },
				["<leader>n"] = { name = "Noice" },
				["<leader>N"] = { name = "Node.js" },
				["<leader>q"] = { name = "Quickfix" },
				["<leader>r"] = { name = "Replace" },
				["<leader>rb"] = { name = "ReplaceMultiBuffer" },
				["<leader>s"] = { name = "Surround" },
				["<leader>S"] = { name = "Session" },
				["<leader>t"] = { name = "Todo" },
			})
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>dL", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[D]iagnostics [L]ist" },
			{ "<leader>dW", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[D]iagnostics [W]orkspace" },
			{ "<leader>qL", "<cmd>TroubleToggle quickfix<cr>", desc = "[Q]uickfix [L]ist" },
		},
		opts = {
			use_diagnostic_signs = true,
			action_keys = {
				jump = { "<C-j>", "<cr>", "<tab>" },
			},
			auto_close = true,
		},
	},

	-- Scrollbar
	{ "petertriho/nvim-scrollbar", event = { "VeryLazy" }, config = true },

	-- Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
		},
		keys = {
			{
				"<leader>nm",
				function()
					require("noice").cmd("last")
				end,
				desc = "[N]oice Last [M]essage",
			},
			{
				"<leader>nh",
				function()
					require("noice").cmd("history")
				end,
				desc = "[N]oice [H]istory",
			},
		},
	},

	-- Current Indent Marker
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			options = { try_as_border = true },
		},
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
}
