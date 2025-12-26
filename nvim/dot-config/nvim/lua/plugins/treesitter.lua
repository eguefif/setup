return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install({
            "lua", "rust", "python", "javascript", "typescript", "css", "html",
            "latex", "norg", "scss", "svelte", "tsx", "typst", "vue", "react",
            "json"
        })
        require("nvim-treesitter").setup({
            highlight = {enable = true},
            indent = {enable = true}
        })
    end
}
