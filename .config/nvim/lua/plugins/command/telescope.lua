return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"olacin/telescope-gitmoji.nvim",
	},
	cmd = "Telescope",
	keys = {
		{
			"<leader><leader>",
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
			desc = "Find Live Grep",
		},
		{
			"<leader>f<leader>",
			"<cmd>lua require('telescope.builtin').buffers({sort_mru=true, ignore_current_buffer=true})<cr>",
			desc = "[F]ind Recent Buffers",
		},
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]ind [F]iles" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[F]ind [R]ecent Files" },
		{ "<leader>fR", "<cmd>Telescope resume<cr>", desc = "[F]ind [R]esume" },
		{ "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "[F]ind [A]utoCommands" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
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
		{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "[F]ind [Q]uickfix" },
		{ "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>", desc = "[F]ind [Q]uickfixhistory" },

		-- git
		{ "<leader>fgl", "<cmd>Telescope git_commits<cr>", desc = "[F]ind [G]it [L]og" },
		{ "<leader>fgh", "<cmd>Telescope git_bcommits<cr>", desc = "[F]ind [G]it [H]istory" },
		{ "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "[F]ind [G]it [B]ranches" },
		{ "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "[F]ind [G]it [S]tatus" },
		{ "<leader>fgS", "<cmd>Telescope git_stash<cr>", desc = "[F]ind [G]it [S]tash" },
		{ "<leader>fgS", "<cmd>Telescope git_stash<cr>", desc = "[F]ind [G]it [S]tash" },
		{ "<leader>fgm", "<cmd>Telescope gitmoji<cr>", desc = "[F]ind [G]it[M]oji" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local telescopeConfig = require("telescope.config")
		local lga_actions = require("telescope-live-grep-args.actions")

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
						["<C-d>"] = false,
						["<C-s>"] = actions.select_horizontal,
						["<C-S-s>"] = actions.select_vertical,
						["<C-f>"] = false,
						["<C-j>"] = false,
						["<C-k>"] = false,
						["<C-u>"] = false,
						["<C-x>"] = actions.delete_buffer,
						["<C-?>"] = "which_key",
						["<PageUp>"] = actions.preview_scrolling_up,
						["<PageDown>"] = actions.preview_scrolling_down,
						["<C-space>"] = actions.to_fuzzy_refine,
					},
					n = {
						["q"] = "close",
						["<C-s>"] = actions.select_horizontal,
						["<C-S-s>"] = actions.select_vertical,
						["<C-c>"] = "close",
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-x>"] = actions.delete_buffer,
						["<C-?>"] = "which_key",
						["<PageUp>"] = actions.preview_scrolling_up,
						["<PageDown>"] = actions.preview_scrolling_down,
						["<C-space>"] = actions.to_fuzzy_refine,
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

				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
							["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
				},
			},
		})

		telescope.load_extension("live_grep_args")
		telescope.load_extension("gitmoji")
		telescope.load_extension("persisted")
	end,
}
