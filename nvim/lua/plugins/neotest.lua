return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
	},
	keys = {
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run file tests",
		},
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Open test output",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>tp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle output panel",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang")({}),
			},
			output = {
				open_on_run = false,
			},
			floating = {
				border = "rounded",
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "neotest-output",
			callback = function()
				vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
			end,
		})
	end,
}
