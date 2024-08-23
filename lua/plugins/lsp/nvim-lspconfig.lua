-- if true then return {} end
local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
  },
}

M.config = function()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = 0 }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gri", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "grr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "grf", function() vim.lsp.buf.format({ async = true }) end, bufopts)
    vim.keymap.set("n", "ggp", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "ggn", vim.diagnostic.goto_next, bufopts)
  end

  local servers = {
    "lua_ls",
    "pyright",
    "tsserver",
    "ruff_lsp",
    "nil_ls",
  }

  -- custom settings
  local gopls_settings = {
    analyses = {
      unusedparams = true,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
  }

  -- setup servers
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "LUASNIP_ENV" },
            -- LUASNIP_ENV is a custom variable declared in `lua/plugins/luasnip.lua`
          },
          hint = {
            enable = true,
          },
        },
        gopls = gopls_settings,
      },
    })
  end
end

M.toggle_inlay_hints = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end

return M
