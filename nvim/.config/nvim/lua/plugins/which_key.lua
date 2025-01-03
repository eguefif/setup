return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>t", group = "Todo comments" },
            { "<leader>b", group = "Buffer" },
            { "<leader>a", group = "Copilote" },
            { "<leader>f", group = "Telescope" },
            { "<leader>l", group = "List" },
            { "<leader>s", group = "Source" },
            { "<leader>c", group = "Code lsp" },
        },
    },
}
