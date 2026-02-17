return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
		},
		views = {
			hover = {
				border = { style = "rounded" },
			},
			popup = {
				border = { style = "rounded" },
			},
			confirm = {
				border = { style = "rounded" },
			},
			popupmenu = {
				border = { style = "rounded" },
			},
		},
	},
}
