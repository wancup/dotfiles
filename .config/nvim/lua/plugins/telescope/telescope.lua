return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"olacin/telescope-gitmoji.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader>f<leader>",
				"<cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>",
				desc = "[F]ind Recent Buffers",
			},
			{ "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "[F]ind [L]ive Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]ind [F]iles" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[F]ind [R]ecent Files" },
			{ "<leader>fR", "<cmd>Telescope resume<cr>", desc = "[F]ind [R]esume" },
			{ "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "[F]ind [A]utoCommands" },
			{ "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[F]ind Current [B]uffer" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "[F]ind [C]ommands" },
			{ "<leader>fC", "<cmd>Telescope command_history<cr>", desc = "[F]ind [C]ommand History" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostics" },
			{ "<leader>fh", "<cmd>Telescope highlights<cr>", desc = "[F]ind [H]ighlights" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[F]ind [K]eymaps" },
			{ "<leader>fvo", "<cmd>Telescope vim_options<cr>", desc = "[F]ind [V]im [O]ptions" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "[F]ind [W]ord" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "[F]ind [S]ymbols" },
			{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "[F]ind Workspace [S]ymbols" },
			{ "<leader>fn", "<cmd>Telescope persisted<cr>", desc = "[F]ind Sessio[n]" },

			-- git
			{ "<leader>fgl", "<cmd>Telescope git_commits<cr>", desc = "[F]ind [G]it [L]og" },
			{ "<leader>fgh", "<cmd>Telescope git_bcommits<cr>", desc = "[F]ind [G]it [H]istory" },
			{ "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "[F]ind [G]it [B]ranches" },
			{ "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "[F]ind [G]it [S]tatus" },
			{ "<leader>fgS", "<cmd>Telescope git_stash<cr>", desc = "[F]ind [G]it [S]tash" },
			{ "<leader>fgS", "<cmd>Telescope git_stash<cr>", desc = "[F]ind [G]it [S]tash" },
			{ "<leader>fgm", "<cmd>Telescope gitmoji<cr>", desc = "[F]ind [G]it[M]oji" },

			-- Code Action
			{ "<leader>a", ":lua vim.lsp.buf.code_action()<cr>", desc = "Code [A]ction", mode = { "n", "v" } },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local telescopeConfig = require("telescope.config")

			-- Allow to find hidden files, exclude .git directory.
			-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-x>"] = false,
							["<C-s>"] = actions.select_horizontal,
							["<C-i>"] = "which_key",
							["<C-j>"] = "select_default",
							["<C-u>"] = false,
							["<C-d>"] = actions.delete_buffer,
							["<esc>"] = actions.close,
						},
						n = {
							["q"] = "close",
						},
					},
					layout_strategy = "vertical",
					vimgrep_arguments = vimgrep_arguments,
				},

				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},

				extensions = {
					gitmoji = {
						action = function(entry)
							local emoji = entry.value.value
							vim.fn.setreg(vim.v.register, emoji)
							vim.fn.setreg("+", emoji)
						end,
					},
					["ui-select"] = {
						require("telescope.themes").get_cursor({
							initial_mode = "normal",
							layout_config = {
								width = 0.8,
								height = 0.35,
							},
						}),
					},
				},
			})

			telescope.load_extension("gitmoji")
			telescope.load_extension("ui-select")
			telescope.load_extension("persisted")
		end,
	},
}
