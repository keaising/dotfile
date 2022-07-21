-- For those plugins who just need a simple setup command

local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  return
end
fidget.setup()


local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end
comment.setup()
