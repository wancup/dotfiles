local copilot_opts = {
	open_mapping = { [[<leader>mc]] },
	cmd = "copilot",
	direction = "horizontal",
	on_open = function(term)
		local height = math.floor(vim.o.lines * 0.4)
		vim.api.nvim_win_set_height(term.window, height)

		local function set_t_keymap(target, command)
			vim.api.nvim_buf_set_keymap(term.bufnr, "t", target, command, { noremap = true, silent = true })
		end
		set_t_keymap("<C-c>", "<Esc>")
		set_t_keymap("<Esc>", "<C-\\><C-n>")
		set_t_keymap("g<C-c>", "<C-c>")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
	end,
}

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<leader>mm", "<cmd>ToggleTerm<cr>", desc = "ToggleTer[m]" },
		{
			"<leader>gg",
			function()
				local Terminal = require("toggleterm.Terminal").Terminal
				local lazygit = Terminal:new({
					cmd = "lazygit",
					direction = "float",
				})
				lazygit:toggle()
			end,
			desc = "lazygit",
		},
		{
			"<leader>gl",
			function()
				local Terminal = require("toggleterm.Terminal").Terminal
				local file_path = vim.fn.expand("%:p")
				local lazygit = Terminal:new({
					cmd = "lazygit --filter '" .. file_path .. "'",
					direction = "float",
				})
				lazygit:toggle()
			end,
			desc = "Git Log Current File",
		},
		{
			"<leader>mr",
			function()
				local Terminal = require("toggleterm.Terminal").Terminal
				local lazydocker = Terminal:new({
					cmd = "lazydocker",
					direction = "float",
				})
				lazydocker:toggle()
			end,
			desc = "lazysql",
		},
		{
			"<leader>mq",
			function()
				local Terminal = require("toggleterm.Terminal").Terminal
				local lazysql = Terminal:new({
					cmd = "lazysql",
					direction = "float",
				})
				lazysql:toggle()
			end,
			desc = "lazysql",
		},
		{
			"<leader>mc",
			desc = "Copilot CLI",
		},
	},
	config = function()
		require("toggleterm").setup({
			open_mapping = { [[<c-\><c-\>]], [[<c-¥><c-¥>]] },
			float_opts = {
				width = math.floor(vim.o.columns * 0.95),
				height = math.floor(vim.o.lines * 0.95),
			},
		})

		local Terminal = require("toggleterm.Terminal").Terminal
		local copilot = Terminal:new(copilot_opts)

		vim.keymap.set("n", "<leader>mc", function()
			copilot:toggle()
		end, { noremap = true, silent = true, desc = "Copilot CLI" })
	end,
}
