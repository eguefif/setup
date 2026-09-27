return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            custom_highlights = function(colors)
                return {
                    -- Completion popup menu (editor background, so the
                    -- rounded border has no filled half-cell around it)
                    Pmenu = {bg = "NONE", fg = colors.subtext0},
                    PmenuBorder = {bg = "NONE", fg = colors.mauve},
                    PmenuSel = {bg = colors.surface0, fg = colors.text, style = {"bold"}},
                    PmenuKind = {bg = "NONE", fg = colors.lavender},
                    PmenuKindSel = {bg = colors.surface0, fg = colors.mauve, style = {"bold"}},
                    PmenuMatch = {fg = colors.peach, style = {"bold"}},
                    PmenuMatchSel = {fg = colors.peach, style = {"bold"}},
                    PmenuSbar = {bg = colors.surface0},
                    PmenuThumb = {bg = colors.mauve},
                    -- Floating windows (LSP hover, diagnostics)
                    NormalFloat = {bg = "NONE", fg = colors.text},
                    FloatBorder = {bg = "NONE", fg = colors.mauve},
                    FloatTitle = {bg = "NONE", fg = colors.lavender, style = {"bold"}}
                }
            end
        })
        vim.cmd.colorscheme("catppuccin")
    end
}
