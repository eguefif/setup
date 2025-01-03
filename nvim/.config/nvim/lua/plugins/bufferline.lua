return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "slant",
					auto_toggle_bufferline = true,
				},
			})
			vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin Buffer" })
			vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Close Right Buffer" })
			vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Close Left Buffer" })
			vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Goto Buffer Left" })
			vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Goto Buffer Right" })
			vim.keymap.set("n", "<leader>bd", function()
				Snacks.bufdelete()
			end, { desc = "Delete Buffer" })
		end,
	},
}
