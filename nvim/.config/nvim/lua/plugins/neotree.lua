return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		lazy = false,
		priority = 1000,
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		keys = {
			{ "<C-n>", "<cmd>Neotree toggle<CR>",  mode = "n", silent = true },
			{ "<C-b>", "<cmd>Neotree buffers<CR>", mode = "n", silent = true },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
				window = {
					mappings = {
						["<space>"] = "none",
						["o"] = "open",
						["c"] = "close_node",
						["<A-a>"] = "add_directory", -- also accepts the optional config.show_path option like "add".
					},
				},
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_by_name = {
							"node_modules",
						},
						hide_by_pattern = { -- uses glob style patterns
							--"*.meta"
						},
						never_show = { -- remains hidden even if visible is toggled to true
							".DS_Store",
							"thumbs.db",
						},
					},
					window = {
						mappings = {
							["o"] = "open",
							["<c-p>"] = "prev_git_modified",
							["<c-n>"] = "next_git_modified",
						},
					},
				},
			})
		end,
	},
	{
		"projekt0n/circles.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("circles").setup({
			})
		end
	}
}
