-- lua/lsp/ruff.lua
---@type LazySpec
return {
  "astral-sh/ruff-lsp",
  enabled = true, -- Enable Ruff LSP
  config = function()
    local lspconfig = require("lspconfig")

    -- Setup Ruff LSP
    lspconfig.ruff.setup({
      on_attach = function(client, bufnr) require("lsp").common_on_attach(client, bufnr) end,
      init_options = {
        settings = {
          fixAll = true,
          organizeImports = true,
          args = {
            "--config",
            "~/.config/ruff/ruff.toml",
          },
        },
      },
    })
  end,
}
