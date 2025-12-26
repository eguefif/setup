return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = {"lua-format"},
                -- Conform will run multiple formatters sequentially
                python = {"ruff_organize_imports", "ruff_format"},
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = {"rustfmt", lsp_format = "fallback"},
                toml = {"taplo"},
                json = {"prettier"},
                vue = {"prettier"},
                javascript = {"prettier"},
                javascriptreact = {"prettier"},
                typescript = {"prettier"},
                typescriptreact = {"prettier"},
            },
            format_on_save = {timeout_ms = 500, lsp_fallback = false}
        })
    end
}
