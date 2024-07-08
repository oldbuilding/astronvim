return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neoconf.nvim",
  },
  config = function()
    -- require("neoconf").setup() -- Ensure neoconf is setup here if needed
    local lspconfig = require("lspconfig")

    lspconfig.ruff_lsp.setup({
      on_attach = function(_, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_option("shiftwidth", 4)
        buf_set_option("tabstop", 4)
        buf_set_option("expandtab", true)
      end,
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    })
    -- Other LSP servers...
  end,
}
