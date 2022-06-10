local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path})
end

require("packer").startup(function(p)
    -- manage packer itself, avoid alerting in every PakcerSync time
    p "wbthomason/packer.nvim"

    require("plugin")(p)
    require("treesitter")(p)
    require("lsp").init(p)

    -- require("completion").init(p)
    -- require("lang/formater")(p)
    -- require("lang/go")(p)
    -- require("git")(p)
    -- require("mapping")(p)

    if packer_bootstrap then
        require("packer").sync()
    end
end)
