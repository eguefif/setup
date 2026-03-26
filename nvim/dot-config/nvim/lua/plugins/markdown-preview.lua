return {
    "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = {"markdown"} end,
    ft = {"markdown"},
    keys = {
        { "<leader>pp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Toggle Markdown Preview" },
        { "<leader>po", "<cmd>MarkdownPreview<cr>",       ft = "markdown", desc = "Open Markdown Preview" },
        { "<leader>px", "<cmd>MarkdownPreviewStop<cr>",   ft = "markdown", desc = "Stop Markdown Preview" },
    },
}
