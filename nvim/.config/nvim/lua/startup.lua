-- If startup without any options, try to open some file and NeoTree

if #vim.v.argv > 2 then
    return
end

local files = {
    "main.go", -- go
    "init.lua", -- lua
    "README.md", -- normal
}

local open_file = ""

for _, file in pairs(files) do
    if vim.fn.findfile(file) ~= "" then
        open_file = file
        break
    end
end

if open_file ~= "" then
    vim.cmd("edit " .. open_file)
    vim.cmd("NeoTreeShow")
    vim.cmd("bp")
end