return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {enabled = true},
        dashboard = {enabled = true},
        explorer = {enabled = true},
        indent = {enabled = true},
        input = {enabled = true},
        -- image = {enabled = true},
        picker = {enabled = true},
        notifier = {enabled = true},
        quickfile = {enabled = true},
        scope = {enabled = true},
        scroll = {enabled = true},
        statuscolumn = {enabled = true},
        words = {enabled = true}
    },
    keys = {
        {
            "<leader>gb",
            function() Snacks.git.blame_line() end,
            desc = "Git Blame Line"
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                if vim.fn.argc() == 0 then
                    require("snacks").dashboard()
                end
            end
        })
    end
}
