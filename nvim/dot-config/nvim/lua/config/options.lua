vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set rnu")
vim.cmd("set autoread")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- This config is necessary for Bufferline
vim.cmd("set termguicolors")

-- Clipboard integration
vim.cmd("set clipboard+=unnamedplus")

-- Expand and collapse code
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99

-- Disable LSP logging and add keymap to toggle
vim.lsp.set_log_level("ERROR")
