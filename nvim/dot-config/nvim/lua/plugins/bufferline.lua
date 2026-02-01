return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {"nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim"},
        lazy = false,
        keys = {
            {"[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer"},
            {"]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer"},
            {"<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer"},
            {"<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer"},
            {"<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer"},
            {
                "<leader>bc",
                "<cmd>BufferLinePickClose<cr>",
                desc = "Close buffer"
            },
            {"<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete current buffer"}
        },
        opts = {options = {close_command = "Bdelete! %d"}}
    }
}
