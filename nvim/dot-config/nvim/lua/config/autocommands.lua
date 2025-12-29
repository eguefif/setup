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
