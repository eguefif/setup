return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		config = function()
			require("CopilotChat").setup({})
			vim.keymap.set(
				"n",
				"<leader>cpc",
				"<cmd>lua require('CopilotChat').open()<cr>",
				{ desc = "open copilote chat" }
			)
			vim.keymap.set("n", "<leader>cpe", "<cmd>Copilot enable<CR>", { desc = "enable copilote" })
			vim.keymap.set("n", "<leader>cpd", "<cmd>Copilot disable<CR>", { desc = "enable copilote" })
		end,
	},
}
