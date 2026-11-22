-- Ported from tmux/.tmux.conf: prefix is ctrl+a, keys are written unshifted (| is shift+\).
local prefix = "ctrl+a"

local function bind(key, action, args)
  rex.bind(prefix .. ">" .. key, action, args)
end

bind("ctrl+a", "pane.send_key", { key = "ctrl+a" })
bind("shift+r", "client.config.reload")

-- Actions ported from tmux/.local/bin/tmux-* scripts; rex.ui.pick replaces fzf.
require("scripts.new_tab")
require("scripts.switch_tab")
require("scripts.close_pane")

-- Tabs (tmux windows)
bind("c", "tab_new_in_directory")
bind("v", "client.tab.new")
bind("r", "client.tab.rename")
bind("shift+x", "client.tab.close")
bind("n", "client.tab.next")
bind("p", "client.tab.previous")
bind("right", "client.tab.next")
bind("left", "client.tab.previous")
bind(",", "client.tab.move", { direction = "backward" })
bind(".", "client.tab.move", { direction = "forward" })
for index = 1, 9 do
  bind(tostring(index), "client.tab.goto", { index = index })
end

-- Sessions
bind("s", "tab_switch_any_session")
bind("shift+s", "session.switch")
bind("enter", "session.previous")
bind("ctrl+r", "session.rename")
bind("o", "client.sidebar.toggle")

-- Panes
bind("shift+\\", "pane.split", { direction = "right" })
bind("\\", "pane.split", { direction = "right" })
bind("-", "pane.split", { direction = "down" })
bind("x", "pane_close_or_tab")
bind("z", "pane.zoom")
bind("]", "pane.balance")

bind("h", "pane.focus", { direction = "left" })
bind("j", "pane.focus", { direction = "down" })
bind("k", "pane.focus", { direction = "up" })
bind("l", "pane.focus", { direction = "right" })

-- tmux swap-pane -U/-D only had H and L; J and K are added for the other axis.
bind("shift+h", "pane.move", { direction = "left" })
bind("shift+j", "pane.move", { direction = "down" })
bind("shift+k", "pane.move", { direction = "up" })
bind("shift+l", "pane.move", { direction = "right" })

bind("b", "pane.move_to_new_tab")
bind("t", "pane.move_to_tab")
bind("y", "pane.move_to_tab")

-- tmux `bind -r` repeats within a timeout; Rex has no timeout, so the first resize
-- enters a mode that keeps h/j/k/l resizing until escape, enter or q.
rex.action({
  name = "resize_sticky",
  title = "Resize Pane and Keep Resizing",
  category = "Pane",
  args = { direction = "string" },
  run = function(ctx, args)
    rex.client.queue("pane.resize", { direction = args.direction })
    rex.client.queue("client.mode.enter", { name = "resize" })
  end,
})

rex.mode("resize", { exclusive = true })

local resize_keys = { h = "left", j = "down", k = "up", l = "right" }
for key, direction in pairs(resize_keys) do
  bind("ctrl+" .. key, "resize_sticky", { direction = direction })
  rex.bind("resize/" .. key, "pane.resize", { direction = direction })
  rex.bind("resize/ctrl+" .. key, "pane.resize", { direction = direction })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/q", "client.mode.exit")

-- Ported from ghostty/config keybinds.
rex.bind("alt+c", "pane.copy")
rex.bind("alt+v", "pane.paste")

-- Rex keeps appearance in app settings, not here; run this once from the command palette
-- to copy what ghostty/config sets.
rex.action({
  name = "apply_ghostty_preferences",
  title = "Apply Ghostty Preferences",
  category = "Settings",
  run = function()
    rex.client.queue("client.theme.import", {
      path = "/Applications/Ghostty.app/Contents/Resources/ghostty/themes/Everforest Dark Hard",
    })
    rex.client.queue("client.setting.terminal.typography.size", { value = 15 })
    rex.client.queue("client.setting.terminal.typography.line_height", { value = 10 })
    rex.client.queue("client.setting.terminal.advanced_fonts.fallback_fonts", { value = "PingFang SC" })
    rex.client.queue("client.setting.terminal.advanced_fonts.ligatures", { value = false })
    rex.client.queue("client.setting.terminal.advanced_fonts.smoothing", { value = true })
    rex.client.queue("client.setting.terminal.cursor.style", { value = "block" })
    rex.client.queue("client.setting.terminal.keyboard.option", { value = "left_sends_alt" })
  end,
})
