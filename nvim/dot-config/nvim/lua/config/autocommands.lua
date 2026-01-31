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
                                      {autotrigger = false})
            vim.keymap.set('i', '<C-Space>', '<C-x><C-o>',
                           {buffer = ev.buf, desc = 'Trigger completion'})
        end

        -- Go to references telescope search
        if client.supports_method("textDocument/references") then
            vim.keymap.set('n', 'grr', function()
                require('telescope.builtin').lsp_references({
                    layout_strategy = 'vertical',
                    layout_config = {width = 0.9, height = 0.9}
                })
            end, {buffer = ev.buf, desc = 'LSP references'})
        end

        if client.supports_method("textDocument/codeAction") then
            -- Auto remove all unused import
            vim.keymap.set('n', '<leader>cr', function()
                vim.lsp.buf.code_action({
                    filter = function(action)
                        if action.title:lower():find("remove all unused import",
                                                     1) then
                            return true
                        end
                        return false
                    end,
                    apply = true
                })
            end, {buffer = ev.buf, desc = "Remove All Unused Import"})

            -- Auto add import 
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
                           {buffer = ev.buf, desc = 'Code Actions'})

            -- Auto add import 
            vim.keymap.set('n', '<leader>i', function()
                vim.lsp.buf.code_action({
                    filter = function(action)
                        local keywords = {'import', 'add', 'use', 'include'}
                        local title = action.title:lower()
                        for _, keyword in ipairs(keywords) do
                            if title:find(keyword, 1, true) then
                                return true
                            end
                        end
                        return false
                    end,
                    apply = true
                })
            end, {buffer = ev.buf, desc = 'Auto Import'})
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

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'gleam'},
    callback = function() vim.treesitter.start() end
})

-- Auto save modified buffers every 10 seconds
local autosave_timer = vim.uv.new_timer()
local autosave_enabled = false
vim.notify('Autosave is disabled')

local function autosave_callback()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified and
            vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
            vim.api.nvim_buf_call(buf, function()
                vim.cmd('silent! write')
            end)
        end
    end
end

vim.keymap.set('n', '<leader>ta', function()
    if autosave_enabled then
        autosave_timer:stop()
        autosave_enabled = false
        vim.notify('Autosave disabled')
    else
        autosave_timer:start(10000, 10000, vim.schedule_wrap(autosave_callback))
        autosave_enabled = true
        vim.notify('Autosave enabled')
    end
end, {desc = 'Toggle autosave'})
