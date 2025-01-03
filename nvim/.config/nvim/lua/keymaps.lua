-- better indent
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- save
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- quickfix
vim.keymap.set("n", "<leader>lq", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>lq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<CS-q>n", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "<CS-q>p", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Diagnostics navigation: from lazyvim
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
vim.keymap.set("n", "<leader>dnd", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>dpd", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "<leader>dne", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "<leader>dpe", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "<leader>dnw", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "<leader>dpw", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
