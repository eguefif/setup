vim.lsp.enable({
    'ruff', 'basedpyright', 'rust_analyzer', 'lua_ls', 'volar', 'vtsls',
    'gleam', 'ruby', 'c', 'postgres_lsp'
})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {current_line = true}
})
