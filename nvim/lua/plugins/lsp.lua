return {
	"williamboman/mason.nvim",
	lazy = false,
	keys = {
		{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
	},
	config = function()
		require("mason").setup()

		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.mod", "go.work", ".git" },
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
					gofumpt = true,
				},
			},
		})
		vim.lsp.config("ts_ls", {})
		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			root_markers = { "project.godot" },
			filetypes = { "gdscript" },
		})

		vim.lsp.enable({ "gopls", "ts_ls", "gdscript" })

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local function map(key, fn, desc)
					vim.keymap.set("n", key, fn, { buffer = args.buf, desc = desc })
				end

				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gr", vim.lsp.buf.references, "Go to references")
				map("gh", vim.lsp.buf.hover, "Hover")
				map("<leader>ca", function()
					require("fzf-lua").lsp_code_actions()
				end, "Code action")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>d", function()
					vim.diagnostic.open_float({ border = "rounded" })
				end, "Diagnostic")
				map("[d", function()
					vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
				end, "Prev diagnostic")
				map("]d", function()
					vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
				end, "Next diagnostic")
			end,
		})
	end,
}
