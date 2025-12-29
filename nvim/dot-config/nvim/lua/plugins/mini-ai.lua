return {
    'nvim-mini/mini.nvim',
    version = '*',
    config = function()
        require('mini.pairs').setup()
        require('mini.comment').setup()
        require('mini.move').setup()
    end
}
