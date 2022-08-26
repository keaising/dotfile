local function get_mbp_frame()
	return hs.screen.primaryScreen():frame()
end

local function get_ext_frame()
	local sf = hs.screen.primaryScreen():frame()
	if #hs.screen.allScreens() > 1 then
		sf = hs.screen.allScreens()[2]:frame()
	end
	return sf
end

hs.hotkey.bind("cmd", "1", function()
	local mbp = get_mbp_frame()
	hs.window.focusedWindow():setFrame(hs.geometry.new(mbp.x, mbp.y, mbp.w, mbp.h))
end)

hs.hotkey.bind("cmd", "2", function()
	local ext = get_ext_frame()
	hs.window
		.focusedWindow()
		:setFrame(hs.geometry.new(ext.x, ext.y + ext.h / 22, ext.w * 2 / 3, ext.h * 10 / 11))
end)

hs.hotkey.bind("cmd", "3", function()
	local ext = get_ext_frame()
	hs.window.focusedWindow():setFrame(hs.geometry.new(ext.x + ext.w * 2 / 3, ext.y, ext.w / 3, ext.h / 2))
end)

hs.hotkey.bind("cmd", "4", function()
	local ext = get_ext_frame()
	hs.window.focusedWindow():setFrame(hs.geometry.new(ext.x + ext.w * 2 / 3, ext.y + ext.h / 2, ext.w / 3, ext.h / 2))
end)
