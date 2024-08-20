-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.automatic_installation = true
      opts.automatic_setup = true
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "bashls",
        "jsonls",
        "lua_ls",
        "omnisharp",
        "ruff",
        "tailwindcss",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      opts.automatic_installation = true
      opts.automatic_setup = true
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "azure-pipelines-ls",
        "beautysh",
        "commitlint",
        "csharp_ls",
        "diagnostic-ls",
        "editorconfig-checker",
        "fixjson",
        "js-debug-adapter",
        "json-lsp",
        "jsonlint",
        "prettier",
        "quick-lint-js",
        "ruff",
        "stylua",
        "selene",
        "typescript-language-server",
        "yaml-language-server",
        "yamlfix",
        "yamllint",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.automatic_installation = true
      opts.automatic_setup = true
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "bash-debug-adapter",
        "debugpy",
        "js-debug-adapter",
        "netcoredbg",
        "node-debug2-adapter",
      })
    end,
  },
}
