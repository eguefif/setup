-- Auto completion
vim.cmd [[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local chars = {};
        for i = 32, 126 do table.insert(chars, string.char(i)) end
        if client.supports_method("textDocument/completion") then
            client.server_capabilities.completionProvider.triggerCharacters =
                chars
            vim.lsp.completion.enable(true, client.id, ev.buf,
                                      {autotrigger = true})
        end
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.supports_method("diagnostic") then
            local opts = {noremap = true, silent = true}
            vim.api.nvim_buf_set_keymap(ev.buf, 'n', '<leader>e',
                                        '<cmd>lua vim.diagnostic.open_float()<CR>',
                                        opts)
        end
    end
})
