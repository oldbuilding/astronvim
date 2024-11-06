-- lua/lsp/mason.lua
---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    maps = {
      ["n"] = {
        ["<Leader>pm"] = { function() require("mason.ui").open() end, desc = "Mason Installer" },
      },
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.automatic_installation = true
      opts.automatic_setup = true
      vim.list_extend(opts.ensure_installed, {
        "bashls",
        "jsonls",
        "lua_ls",
        "ruff",
        "pyright",
        -- "omnisharp",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = function(_, opts)
      -- overrides `require("mason-null-ls").setup(...)`
      opts.automatic_installation = true
      opts.automatic_setup = true
      -- add more things to the ensure_installed table protecting against community packs modifying it
      local additional_servers = {
        "csharp_ls",
        "diagnostic-ls",
        "editorconfig_checker",
        "fixjson",
        "json-lsp",
        "jsonlint",
        -- "prettier",
        -- "quick-lint-js",
        "ruff",
        "stylua",
        "selene",
        -- "typescript-language-server",
        "shfmt",
        "yaml-language-server",
        "yamlfix",
        "yamllint",
      }
      opts.ensure_installed = require("utils.objects").insert_unique(opts.ensure_installed or {}, additional_servers)
    end,
    config = function()
      require("your.null-ls.config") -- require your null-ls config here (example below)
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.automatic_installation = true
      opts.automatic_setup = true
      opts.ensure_installed = require("utils.objects").insert_unique(opts.ensure_installed, {
        "bash-debug-adapter",
        "debugpy",
      })
    end,
  },
}
