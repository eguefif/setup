local data_path = vim.fn.stdpath("data")
if type(data_path) == "table" then
    data_path = data_path[0]
end

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        local builtin = require("telescope.builtin")
        require("telescope").setup({
            pickers = {
                find_files = {
                    theme = "ivy",
                },
            },
            extensions = {
                fzf = {},
            },
        })
        vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>ep", function()
            builtin.find_files({
                cwd = vim.fs.joinpath(data_path, "lazy"),
            })
        end)

        -- Look in nvim config
        vim.keymap.set("n", "<leader>en", function()
            builtin.find_files({
                cwd = vim.fs.joinpath(os.getenv("HOME"), "lab", "setup"),
                follow = true,
                hidden = true,
            })
        end)
        require(".telescope.multigrep").setup()
    end,
}
