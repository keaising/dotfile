-- For those plugins who just need a simple setup command

local plugin_list = {
	fidget = {},
	Comment = {},
	inc_rename = {},
	im_select = {
		default_im_select = "com.apple.keylayout.ABC",
		disable_auto_restore = 0,
	},
	lsp_signature = { bind = false },
}

for p, opt in pairs(plugin_list) do
	local status_ok, plugin = pcall(require, p)
	if status_ok then
		plugin.setup(opt)
	end
end
