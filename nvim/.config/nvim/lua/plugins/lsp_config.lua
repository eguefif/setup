return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    config = function()
        require("lspconfig").elixirls.setup({
            -- Unix
            -- cmd = { "~/.local/share/nvim/mason/bin/elixir-ls" },
            cmd = { "elixir-ls" },
        })
        local lspconfig = require('lspconfig')
        require 'lspconfig'.clangd.setup {}

        lspconfig.volar.setup {
            -- add filetypes for typescript, javascript and vue
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            init_options = {
                vue = {
                    -- disable hybrid mode
                    hybridMode = false,
                },
            },
        }
        -- you must remove ts_ls setup
        -- lspconfig.ts_ls.setup {}
        require("lspconfig").lua_ls.setup({})
        require("lspconfig").rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = false,
                    },
                },
            },
        })
        require("lspconfig").sqlls.setup({})
        require("lspconfig").eslint.setup {}
        --require("lspconfig").rubocop.setup({})
        -- TODO: check solargraph
        require("lspconfig").ruby_lsp.setup({
            filetypes = { "ruby" },
        })
        require("lspconfig").ruff.setup({})
        require("lspconfig").clangd.setup({})
        require("lspconfig").jsonls.setup({})

        require("lspconfig").eslint.setup({})
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end,
                    })
                end

                if client.supports_method("textDocument/code_action") then
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                end
                if client.supports_method("textDocument/definition") then
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
                end
                if client.supports_method("textDocument/rename") then
                    vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename" })
                end
                if client.supports_method("textDocument/references") then
                    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "References" })
                end
                if client.supports_method("textDocument/implementation") then
                    vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "Implementation" })
                end
            end,
        })
    end,
}
