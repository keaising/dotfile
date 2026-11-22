-- Ported from tmux/.local/bin/tmux-new-window.
local util = require("scripts.util")

local home = os.getenv("HOME")
-- Actions run inside the Rex server, whose PATH lacks Homebrew.
local fd = "/opt/homebrew/bin/fd"
local code_root = home .. "/code"

local function lines(text)
  local out = {}
  for line in (text or ""):gmatch("[^\n]+") do
    table.insert(out, line)
  end
  return out
end

local function basename(path)
  return (path:gsub("/+$", ""):match("([^/]+)$") or path):gsub("%.", "_")
end

local function dir_item(path)
  local title = path
  if path:sub(1, #code_root + 1) == code_root .. "/" then
    title = path:sub(#code_root + 2)
  elseif path:sub(1, #home) == home then
    title = "~" .. path:sub(#home + 1)
  end
  return { id = path, title = title }
end

local function pane_cwd(ctx)
  local ok, result = pcall(rex.call, "block.method", {
    session_id = ctx.session_id,
    block_id = ctx.block_id,
    method = "process",
  })
  if ok and result and result.foreground then
    return result.foreground.cwd
  end
  return nil
end

local function directories(ctx)
  local items = {}
  local cwd = pane_cwd(ctx)
  if cwd then
    table.insert(items, dir_item(cwd))
  end
  local found = util.run({
    fd, "--type", "d", "--max-depth", "3", "--hidden", "--follow",
    "--exclude", "bin", "--exclude", "go", "--exclude", "include",
    "--exclude", "lib", "--exclude", "n", "--exclude", "share",
    ".", code_root,
  })
  for _, dir in ipairs(lines(found)) do
    table.insert(items, dir_item((dir:gsub("/$", ""))))
  end
  for _, dir in ipairs({ home .. "/.config", home .. "/.local", home .. "/Downloads" }) do
    table.insert(items, dir_item(dir))
  end
  return items
end

rex.action({
  name = "tab_new_in_directory",
  title = "New Tab in Directory…",
  category = "Tab",
  run = function(ctx)
    local dir = util.pick("New Tab in Directory", directories(ctx))
    if not dir then
      return
    end

    -- The server's active window can differ from the tab the app shows, so anchor on the pane's tab.
    local current_window = util.window_of(ctx.session_id, ctx.block_id)
    local next_window = nil
    local view = rex.call("session.view", { session_id = ctx.session_id })
    for index, window in ipairs(view.windows or {}) do
      if window.window_id == current_window and view.windows[index + 1] then
        next_window = view.windows[index + 1].window_id
      end
    end

    local created = rex.call("session.new_window", {
      session_id = ctx.session_id,
      window_label = basename(dir),
      layout = { block = { flavor = "com.superlogical.terminal.shell", options = { cwd = dir } } },
    })
    -- Without before_window_id the window moves to the end, which is right after a last current tab.
    rex.call("session.move_window", {
      session_id = ctx.session_id,
      window_id = created.window_id,
      before_window_id = next_window,
    })
    -- Switching right after the picker closes doesn't stick in the app; rex.sleep isn't
    -- available to key-bound actions, so wait through /bin/sleep.
    util.run({ "/bin/sleep", "0.3" })
    rex.client.queue("session.select", { session_id = ctx.session_id, window_id = created.window_id })
  end,
})
