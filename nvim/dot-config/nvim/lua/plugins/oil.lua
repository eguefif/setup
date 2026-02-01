return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ["<leader>oo"] = {
                "actions.select",
                opts = {
                    vertical = true,
                    desc = "Open the entry under the cursor in a vertical split"
                }
            },
            ["<leader>ovh"] = {
                "actions.select",
                opts = {
                    vertical = true,
                    desc = "Open the entry under the cursor in an horizontal split"
                }
            }
        }
    },

    -- Optional dependencies
    dependencies = {{"nvim-mini/mini.icons", opts = {}}},
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false
}
