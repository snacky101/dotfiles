local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>qq", "<cmd>wqa<cr>", opts)
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", opts)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", opts)
