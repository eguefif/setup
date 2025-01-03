return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>b", group = "Buffer" },
			{ "<leader>a", group = "Copilote" },
			{ "<leader>f", group = "Telescope" },
			{ "<leader>l", group = "List" },
			{ "<leader>d", group = "Lsp" },
			{ "<leader>s", group = "Source" },
			{ "<leader>c", group = "Code lsp" },
		},
	},
}
