vim.lsp.enable({
    'ruff', 'basedpyright', 'rust_analyzer', 'lua_ls', 'volar', 'vtsls',
    'gleam', 'ruby'
})

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = {current_line = true}
})

-- TODO: check if JS vue lsp works Make erb linter works AUTOSAVE
-- Auto save toggle keymap
