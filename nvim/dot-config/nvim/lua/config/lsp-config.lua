vim.lsp.enable({
    'basedpyright', 'rust_analyzer', 'lua_ls', 'volar', 'vtsls', 'gleam',
    'ruby', 'c', 'postgres_lsp', 'elixir-ls'
})

vim.diagnostic.config({
    virtual_text = true
    -- virtual_lines = {current_line = false}
})
