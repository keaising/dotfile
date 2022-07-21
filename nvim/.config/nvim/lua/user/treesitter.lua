local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    -- ensure_installed = "all", -- one of "all" or a list of languages
	ensure_installed = {
		"lua",
		"go",
		"bash",
		"dockerfile",
		"go",
		"gomod",
		"gowork",
		"html",
		"http",
		"javascript",
		"json",
		"markdown",
		"python",
		"regex",
		"rust",
		"sql",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
})
