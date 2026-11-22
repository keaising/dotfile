local M = {}

function M.run(argv)
  local process, err = rex.exec.start(argv)
  if not process then
    rex.log("command failed to start: " .. table.concat(argv, " ") .. ": " .. tostring(err))
    return nil
  end
  local result = process:wait()
  if not result.ok then
    rex.log("command failed: " .. table.concat(argv, " ") .. "\n" .. result.stderr)
    return nil
  end
  return result.stdout
end

function M.pick(title, items)
  -- rex.ui.pick rejects duplicate ids; keep the first occurrence so the order holds.
  local unique = {}
  local seen = {}
  for _, item in ipairs(items) do
    local id = type(item) == "table" and item.id or item
    if not seen[id] then
      seen[id] = true
      table.insert(unique, item)
    end
  end
  if #unique == 0 then
    return nil
  end
  local choice = rex.ui.pick({ title = title, items = unique })
  if type(choice) == "table" then
    return choice.id
  end
  return choice
end

function M.window_of(session_id, block_id)
  local view = rex.call("session.view", { session_id = session_id })
  for _, window in ipairs(view.windows or {}) do
    local block_ids = {}
    local found = false
    for _, layer in ipairs(window.layers or {}) do
      for _, block in ipairs(layer.blocks or {}) do
        table.insert(block_ids, block.block_id)
        if block.block_id == block_id then
          found = true
        end
      end
    end
    if found then
      return window.window_id, block_ids
    end
  end
  return nil, {}
end

return M
