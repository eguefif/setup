vim.lsp.enable({'ruff', 'basedpyright', 'rust_analyzer', 'lua_ls', 'volar', 'vtsls'})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {current_line = true}
})

