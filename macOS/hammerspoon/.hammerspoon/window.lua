-- Window management hotkeys
hs.hotkey.bind({ "cmd", "ctrl" }, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w * 3 / 4
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.w * 1 / 4
    f.y = max.y
    f.w = max.w * 3 / 4
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "Down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.w * 1 / 20
    f.y = max.h * 1 / 20
    f.w = max.w * 0.9
    f.h = max.h * 0.95
    win:setFrame(f)
end)
