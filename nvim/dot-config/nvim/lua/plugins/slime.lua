return {
    -- slime (REPL integration)
    {
        "jpalardy/vim-slime",
        keys = {
            { "<leader>rc", "<cmd>SlimeConfig<cr>", desc = "Slime Config" },
            { "<leader>rr", desc = "Slime Send Cell" },
            { "<leader>rl", desc = "Slime Send Line" },
            { "<leader>rr", desc = "Slime Send Selection", mode = "v" },
        },
        init = function()
            vim.g.slime_target = "tmux"
            vim.g.slime_cell_delimiter = "# %%"
            vim.g.slime_bracketed_paste = 1
        end,
        config = function()
            vim.keymap.set("n", "<leader>rr", "<Plug>SlimeSendCell", { desc = "Slime Send Cell" })
            vim.keymap.set("n", "<leader>rl", "<Plug>SlimeLineSend", { desc = "Slime Send Line" })
            vim.keymap.set("v", "<leader>rr", "<Plug>SlimeRegionSend", { desc = "Slime Send Selection" })
        end
    }
}
