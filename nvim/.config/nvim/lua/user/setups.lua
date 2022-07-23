-- For those plugins who just need a simple setup command

local plugin_list = {
	'fidget',
	"Comment",
	"inc_rename"
}

for _, p in pairs(plugin_list) do
	local status_ok, plugin = pcall(require, p)
	if status_ok then
		plugin.setup()
	end
end

-- For those init in a strange way

-- local ok_lines, lsp_lines = pcall(require, "lsp_lines")
-- if not ok_lines then
--   return
-- end
-- lsp_lines.register_lsp_virtual_lines()
