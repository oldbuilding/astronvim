local M = {}

M.setup = function()
  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    signs = true,
    severity_sort = true,
  })
end

return M
