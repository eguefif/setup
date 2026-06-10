return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = {"lua-format"},
                -- Conform will run multiple formatters sequentially
                python = {"ruff_organize_imports", "ruff_format"},
                -- You can customize some of the format options for the filetype (:help conform.format)
                c = {"clang-format"},
                sql = {"pg_format"},
                rust = {"rustfmt", lsp_format = "fallback"},
                ruby = {"rubocop", lsp_format = "fallback"},
                eruby = {"erb_lint"},
                toml = {"taplo"},
                json = {"jq"},
                -- vue = {"eslint"},
                gleam = {"gleam"},
                elixir = {"mix"},
                heex = {"mix"},
                go = {"gofmt"},
                java = {"google-java-format"},
                prolog = {lsp_format = "fallback"}
                -- javascript = {"prettier"},
                -- javascriptreact = {"prettier"},
                -- typescript = {"eslint"},
                -- typescriptreact = {"prettier"}
            },
            formatters = {
                erb_lint = {
                    command = "erblint",
                    args = {"-a", "$FILENAME"},
                    stdin = false
                },
                rubocop = {
                    command = "bundle",
                    args = {"exec", "rubocop", "-a", "-f", "quiet", "--stderr", "--force-exclusion", "--stdin", "$FILENAME"},
                    condition = function(_, ctx)
                        return vim.fs.find("Gemfile", {path = ctx.dirname, upward = true})[1] ~= nil
                    end
                }
            },
            format_after_save = {timeout_ms = 3000, lsp_fallback = false}
        })
    end
}
