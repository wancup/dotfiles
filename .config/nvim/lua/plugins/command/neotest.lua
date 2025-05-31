local test_ext_regexes = {
	"%.spec%.js$",
	"%.spec%.jsx$",
	"%.test%.js$",
	"%.test%.jsx$",
	"%.spec%.ts$",
	"%.spec%.tsx$",
	"%.test%.ts$",
	"%.test%.tsx$",
}

local function is_e2e_test_dir(file_path)
	local e2e_dirs = { "tests", "e2e" }
	for _, dir in ipairs(e2e_dirs) do
		if string.match(file_path, dir) then
			return true
		end
	end
	return false
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
		"thenbe/neotest-playwright",
	},
	cmd = { "Neotest" },
	keys = {
		{
			"<leader>t<leader>",
			function()
				require("neotest").output.open()
			end,
			desc = "[T]est Output",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "[T]est [R]un",
		},
		{
			"<leader>tR",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "[T]est [R]un(Current File)",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle()
			end,
			desc = "[T]est [W]atch Toggle",
		},
		{
			"<leader>tW",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "[T]est [W]atch Toggle(Current File)",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "[T]est [S]ummary Toggle",
		},
		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "[T]est [O]utput Panel",
		},
		{
			"<leader>ta",
			function()
				require("neotest").playwright.attachment()
			end,
			desc = "[T]est [A]ttachment(Playwright)",
		},
		{
			"<leader>tp",
			"<cmd>NeotestPlaywrightPreset<cr>",
			desc = "[T]est [P]resets(Playwright)",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest")({
					is_test_file = function(file_path)
						if is_e2e_test_dir(file_path) then
							return false
						end

						if string.match(file_path, "__tests__") then
							return true
						end

						for _, ext in ipairs(test_ext_regexes) do
							if string.match(file_path, ext) then
								return true
							end
						end
						return false
					end,
				}),
				require("neotest-playwright").adapter({
					options = {
						is_test_file = function(file_path)
							if not is_e2e_test_dir(file_path) then
								return false
							end

							for _, ext in ipairs(test_ext_regexes) do
								if string.match(file_path, ext) then
									return true
								end
							end
							return false
						end,
					},
				}),
			},
			consumers = {
				playwright = require("neotest-playwright.consumers").consumers,
			},
		})
	end,
}
