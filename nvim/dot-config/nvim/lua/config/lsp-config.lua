vim.lsp.enable({
    'basedpyright', 'rust_analyzer', 'lua_ls', 'volar', 'vtsls', 'gleam',
    'solargraph', 'c', 'postgres_lsp', 'elixir-ls', 'gopls', 'clojure_lsp',
    'prolog_ls'
})

vim.diagnostic.config({
    virtual_text = true
    -- virtual_lines = {current_line = false}
})
