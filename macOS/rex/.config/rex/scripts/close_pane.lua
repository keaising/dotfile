-- Rex's pane.close leaves the last pane of a tab open; tmux kill-pane closes the window instead.
local util = require("scripts.util")

rex.action({
  name = "pane_close_or_tab",
  title = "Close Pane or Tab",
  category = "Pane",
  run = function(ctx)
    local _, block_ids = util.window_of(ctx.session_id, ctx.block_id)
    if #block_ids > 1 then
      rex.client.queue("pane.close")
    else
      rex.client.queue("client.tab.close")
    end
  end,
})
