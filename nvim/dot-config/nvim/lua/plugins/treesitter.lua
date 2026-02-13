return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install({
            "lua", "rust", "python", "javascript", "typescript", "css", "html",
            "latex", "scss", "svelte", "tsx", "typst", "vue", "json", "gleam",
            "c"
        })
        require("nvim-treesitter").setup({
            highlight = {enable = true},
            indent = {enable = true}
        })
    end
}
