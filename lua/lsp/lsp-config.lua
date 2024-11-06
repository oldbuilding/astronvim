-- lua/lsp/lsp-config.lua
local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
  },
}

local explicit_exclusions = {
  "basedpyright",
  "pylsp",
}

M.config = function()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local Paths = require("utils.paths")
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local on_attach = function(client, bufnr)
    -- Disable formatting for all clients except Ruff
    if client.name ~= "ruff" then client.server_capabilities.document_formatting = false end

    -- Format on save only for Ruff
    if client.name == "ruff" and client.server_capabilities.document_formatting then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Format", {
          clear = true,
        }),
        buffer = bufnr,
        callback = function() vim.lsp.buf.format() end,
      })
    end

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

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
    "bashls",
    "lua_ls",
    "ts_ls",
    "ruff",
    "pyright",
    "editorconfig_checker",
    "nil_ls",
  }

  local pyright_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          ignore = { "*" }, -- Ignore all files to exclusively use Ruff for linting
          diagnosticSeverityOverrides = {
            reportMissingImports = "error",
            reportUnusedImport = "none",
          },
        },
      },
    },
  }

  local lua_ls_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        format = { enable = false },
      },
    },
  }

  -- Setup servers
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end

  -- Additional specific server configurations
  lspconfig.pyright.setup(pyright_config)
  lspconfig.lua_ls.setup(lua_ls_config)
end

return M
