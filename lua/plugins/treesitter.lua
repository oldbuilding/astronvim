-- Customize Treesitter
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bashls",
      "bash-language-server",
      "clangd",
      "diagnosticls",
      "eslint",
      "lua",
      "lua_ls",
      "vim",
      "tsserver",
      "javascript",
      "typescript",
      "tsx",
      "css",
      "json",
      "html",
      "python",
      "ruff",
      "ruff_lsp",
      "yamlls",
      "jsonls",
    })
  end,
}
