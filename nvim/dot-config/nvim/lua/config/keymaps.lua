-- Keep visual selection after indenting
vim.keymap.set('v', '<', '<gv', {desc = 'Indent left and reselect'})
vim.keymap.set('v', '>', '>gv', {desc = 'Indent right and reselect'})

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                       {buffer = bufnr, desc = 'Go to definition'})
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                       {buffer = bufnr, desc = 'Go to declaration'})

        -- Enable and toggle inlay hints if supported
        if client and client.supports_method('textDocument/inlayHint') then
            -- Enable inlay hints by default
            vim.lsp.inlay_hint.enable(false, {bufnr = bufnr})

            vim.keymap.set('n', '<leader>th', function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({bufnr = bufnr}),
                    {bufnr = bufnr})
            end, {buffer = bufnr, desc = 'Toggle inlay hints'})
        end
    end
})

local lsp_log_level = false
vim.keymap.set('n', '<leader>tl', function()
    if lsp_log_level then
        vim.lsp.set_log_level("DEBUG")
        vim.notify("LSP log level set to Debug")
    else
        vim.lsp.set_log_level("OFF")
        vim.notify("LSP log OFF")
        lsp_log_level = not lsp_log_level
    end
end, {desc = "Toggle lSP logging"})
