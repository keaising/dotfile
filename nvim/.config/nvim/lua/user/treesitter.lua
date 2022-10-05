local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			},
		},
	},
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ensure_installed = {
		"bash",
		"dockerfile",
		"gomod",
		"gowork",
		"html",
		"http",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"regex",
		"rust",
		-- "sql",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
	ignore_install = { "go" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "sql", "go" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css", "go" } },
	autotag = {
		enable = true,
	},
})
