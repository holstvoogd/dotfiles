return {
	-- Core plugins
	{
		"LazyVim/LazyVim",
		import = "lazyvim.plugins",
	},

	-- Navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
		},
	},

	-- Ruby/Rails
	{
		"tpope/vim-rails",
		ft = { "ruby", "eruby", "haml", "slim" },
	},
	{
		"vim-ruby/vim-ruby",
		ft = { "ruby", "eruby" },
	},
}
