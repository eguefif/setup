return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({})

        -- Add group descriptions
        wk.add({
            {"<leader>o", group = "Oil"}, {"<leader>r", group = "Slime"},
            {"<leader>s", group = "Snacks"}, {"<leader>b", group = "Buffer"},
            {"<leader>f", group = "Find (Telescope)"},
            {"<leader>g", group = "Git"}, {"<leader>h", group = "Git Hunk"},
            {"<leader>t", group = "Toggle"}
        })
    end,
    keys = {
        {
            "<leader>?",
            function() require("which-key").show({global = false}) end,
            desc = "Buffer Local Keymaps (which-key)"
        }
    }
}
