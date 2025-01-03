return
{
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup()
        vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope keywords=TODO<CR>", { desc = "Find Todo" })
        vim.keymap.set("n", "<leader>tf", "<cmd>TodoTelescope keywords=FIX<CR>", { desc = "Find Fix" })
        vim.keymap.set("n", "<leader>tn", "<cmd>TodoTelescope keywords=NOTE<CR>", { desc = "Find Note" })
        vim.keymap.set("n", "<leader>th", "<cmd>TodoTelescope keywords=HACK<CR>", { desc = "Find Hack" })
        vim.keymap.set("n", "<leader>tw", "<cmd>TodoTelescope keywords=WARNING<CR>", { desc = "Find Warning" })

        vim.keymap.set("n", "]t", function()
            require("todo-comments").jump_next()
        end, { desc = "Next todo comment" })

        vim.keymap.set("n", "[t", function()
            require("todo-comments").jump_prev()
        end, { desc = "Previous todo comment" })
    end
}
