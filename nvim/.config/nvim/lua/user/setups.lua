-- For those plugins who just need a simple setup command

local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  return
end
fidget.setup()


local ok_comment, comment = pcall(require, "Comment")
if not ok_comment then
  return
end
comment.setup()
