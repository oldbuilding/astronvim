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
    -- format on save
    if client.server_capabilities.document_formatting then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Format", {
          clear = true,
        }),
        buffer = bufnr,
        callback = function() vim.lsp.buf.format() end,
      })
    end
    if require("utils.objects").contains(explicit_exclusions, client.name) then
      client.stop()
      require("utils.logging").notify("Excluded LSP: " .. client.name, vim.log.levels.INFO)
      return
    end

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
    "bashls",
    "lua_ls",
    "tsserver",
    "ruff",
    "ruff_lsp",
    "pyright",
    "editorconfig_checker",
    "nil_ls",
  }

  local pyright_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          autoImportCompletions = true,
          diagnosticSeverityOverrides = {
            reportMissingImports = "error",
            reportUnusedImport = "none",
          },
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { "*" },
        },
      },
    },
  }

  local editorconfig_checker_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        format = { enabled = false },
        lint = { enabled = false },
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

  local ruff_lsp_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings_ = {
      linelength = 180,
      ruff = {
        format = {
          enable = true,
        },
        lint = { select = { "ALL" } },
        fix = { select = { "ALL" } },
      },
    },
    init_options = {
      settings_ = {
        linelength = 180,
        editorconfig_checker = nil,
        ruff = {
          format = {
            enable = true,
          },
          lint = { select = { "ALL" } },
          fix = { select = { "ALL" } },
        },
      },
    },
  }

  local ruff_config = {
    on_attach = function(client, bufnr)
      -- Default on_attach function
      require("lsp").common_on_attach(client, bufnr)
    end,
    settings = {
      ruff = {
        -- General configuration options
        configuration = Paths.find_project_root() .. "/.ruff.toml",
        --       configurationPreference = "editorFirst", -- "filesystemFirst",
        configurationPreference = "ruff.toml", -- Default: Use 'pyproject.toml' over 'ruff.toml'
        exclude = {}, -- Default: No paths are excluded

        -- Linting options
        lint = {
          select = {}, -- Default: Select all rules
          ignore = {}, -- Default: Ignore no rules
          extendSelect = {}, -- Default: Do not extend selected rules
          preview = false, -- Default: Do not enable preview mode
        },

        -- Formatting options
        format = {
          lineLength = 180,
          preview = false, -- Default: Do not enable preview mode
        },
      },
    },
  }

  local omnisharp_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    filetypes = { "cs", "csproj", "sln" },
  }

  local csharp_ls_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "cs", "csproj", "sln" },
  }

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
        omnisharp = omnisharp_config,
        ruff = ruff_config,
        ruff_lsp = ruff_lsp_config,
        pyright = pyright_config,
        editorconfig_checker = editorconfig_checker_config,
        lua_ls = lua_ls_config,
        csharp_ls = csharp_ls_config,
      },
    })
  end
end

M.toggle_inlay_hints = function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end

return M
