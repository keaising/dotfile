return {
  {
    "RRethy/vim-illuminate",
    config = function()
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          vim.cmd "hi link illuminatedWord LspReferenceText"
        end,
      })
    end
  }
}
