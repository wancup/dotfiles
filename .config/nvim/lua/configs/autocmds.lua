vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- avoid to automatic comment out
    vim.opt.formatoptions:remove("r")
    vim.opt.formatoptions:remove("o")
  end
})
