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
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Jump to the next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Jump to the previous Diagnostic" })
vim.keymap.set("n", "[e", diagnostic_goto(true, "ERROR"), { desc = "Jump to the next Error" })
vim.keymap.set("n", "]e", diagnostic_goto(false, "ERROR"), { desc = "Jump to the previous Error" })
vim.keymap.set("n", "[w", diagnostic_goto(true, "WARN"), { desc = "Jump to the next Warning" })
vim.keymap.set("n", "]w", diagnostic_goto(false, "WARN"), { desc = "Jump to the previous Warning" })
