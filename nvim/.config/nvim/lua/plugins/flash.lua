return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
        { "<leader>ps", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "<leader>pS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "<leader>pr", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "<leader>pR", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>",      mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
