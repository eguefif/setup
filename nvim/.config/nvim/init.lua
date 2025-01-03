require(".lazy")
require(".keymaps")
require(".options")

vim.keymap.set("n", "<leader>sx", "<cmd>source %<CR>", { desc = "Source File" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute Lua" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute Lua visual mode" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
