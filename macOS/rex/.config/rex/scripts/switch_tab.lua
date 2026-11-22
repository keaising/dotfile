-- Ported from tmux/.local/bin/tmux-switch-window.
local util = require("scripts.util")

rex.action({
  name = "tab_switch_any_session",
  title = "Switch to Tab in Any Session…",
  category = "Tab",
  run = function()
    local items = {}
    for _, session in ipairs(rex.call("session.list", {}).sessions) do
      local view = rex.call("session.view", { session_id = session.session_id })
      for index, window in ipairs(view.windows or {}) do
        table.insert(items, {
          id = session.session_id .. "|" .. window.window_id,
          title = session.label .. "  " .. index .. "  " .. (window.label or ""),
        })
      end
    end

    local choice = util.pick("Switch Tab", items)
    if not choice then
      return
    end
    local session_id, window_id = choice:match("^(.-)|(.*)$")
    rex.client.queue("session.select", { session_id = session_id, window_id = window_id })
  end,
})
