return {
    'brenoprata10/nvim-highlight-colors',
    name = "nvim-hightlight-colors",
    lazy = false,
    priority = 1000,
    config = function()
        -- Ensure termguicolors is enabled if not already
        vim.opt.termguicolors = true

        require('nvim-highlight-colors').setup({})
    end
}
