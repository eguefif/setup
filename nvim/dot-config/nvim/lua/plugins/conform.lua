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
                ruby = {"rubocop", lsp_format = "fallback"},
                eruby = {"erb_lint"},
                toml = {"taplo"},
                json = {"prettier"},
                vue = {"prettier"},
                gleam = {"gleam"},
                javascript = {"prettier"},
                javascriptreact = {"prettier"},
                typescript = {"prettier"},
                typescriptreact = {"prettier"}
            },
            formatters = {
                erb_lint = {
                    command = "erblint",
                    args = {"-a", "$FILENAME"},
                    stdin = false
                }
            },
            format_after_save = {timeout_ms = 3000, lsp_fallback = false}
        })
    end
}
