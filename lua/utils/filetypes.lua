if true then return {} end

return {
  -- Ensure .csproj files are correctly identified as csproj
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.csproj",
    command = "setfiletype csproj",
  })
}
