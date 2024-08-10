-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "awk_ls",
        "bashls",
        "clangd",
        "dockerls",
        "grammarly",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "pylsp",
        "pyright",
        "ruff",
        "ruff_lsp",
        "tailwindcss",
        -- "eslint-lsp",
        -- "eslint_d",
        -- add more arguments for adding more language servers
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "azure-pipelines-ls",
        "clang-format",
        "codespell",
        "commitlint",
        "cppcheck",
        "cpplint",
        "csharp_ls",
        "diagnostic-ls",
        "editorconfig-checker",
        "editorconfig-checker",
        "fixjson",
        "js-debug-adapter",
        "json-lsp",
        "jsonlint",
        "luacheck",
        "prettier",
        "proselint",
        "pylint",
        "quick-lint-js",
        "ruff",
        "shfmt",
        "sqlfmt",
        "sqlls",
        "stylua",
        "typescript-language-server",
        "yaml-language-server",
        "yamlfix",
        "yamllint",
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "bash-debug-adapter",
        "cpptools",
        "debugpy",
        "js-debug-adapter",
        "netcoredbg",
        "node-debug2-adapter",
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
