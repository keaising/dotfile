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

local ok_rename, rename = pcall(require, "inc_rename")
if not ok_rename then
  return
end
rename.setup()

local ok_lines, lsp_lines = pcall(require, "lsp_lines")
if not ok_lines then
  return
end
lsp_lines.register_lsp_virtual_lines()
