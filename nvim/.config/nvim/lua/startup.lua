-- if in go project, open main.go and toggle NeoTree as default

local files = {
    "main.go", -- go
    "init.lua", -- lua
    "README.md", -- normal
}

local ignore = {
    "COMMIT_EDITMSG",
}

local open_tree = false

for _, file in pairs(files) do
    local found = vim.fn.findfile(file)
    if found ~= "" then
        open_tree = true
        vim.cmd("edit " .. file)
        break
    end
end

if open_tree then
    vim.cmd("NeoTreeShow")
    vim.cmd("bp")
end
