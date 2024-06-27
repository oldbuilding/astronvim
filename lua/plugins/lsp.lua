if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "neovim/nvim-lspconfig",
  config = function()
    require("neoconf").setup() -- Ensure neoconf is setup here if needed
    local lspconfig = require "lspconfig"

    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    }
    -- Other LSP servers...
  end,
}
