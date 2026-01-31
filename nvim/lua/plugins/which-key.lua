return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>c", group = "code" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "hunk" },
			{ "<leader>q", group = "quit" },
			{ "<leader>r", group = "rename" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "test" },
		},
	},
}
