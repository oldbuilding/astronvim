return {
  "neovim/nvim-lspconfig",
  event = {"BufReadPre", "BufNewFile"},
  dependencies = {
    { "folke/neoconf.nvim", opts = {}},
  },
  config = function()

    local lspconfig = require("lspconfig")
    local Paths = require("utils.paths")
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach = function(client, bufnr)
      -- format on save
      if client.server_capabilities.document_formatting then
        vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Format", {
          clear = true,
        }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
      end
    end


    lspconfig.ruff_lsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings_ = {
        linelength = 180,
        ruff = {
          format = {
            enable = true,
          },
          lint = { select = { "ALL" }},
          fix = { select = { "ALL" }},
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
            lint = { select = { "ALL" }},
            fix = { select = { "ALL" }},
          },
        }
      },
    })


    lspconfig.ruff.setup {
        on_attach = function(client, bufnr)
            -- Default on_attach function
            require('lsp').common_on_attach(client, bufnr)
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
                }
            }
        }
    }


    -- lspconfig.ruff.setup({
    --   on_attach = ruff_on_attach,
    --   init_options = {
    --     settings = {
    --       configuration = Paths.find_project_root() .. "/.ruff.toml",
    --       configurationPreference = "editorFirst", -- "filesystemFirst",
    --       linelength = 180,
    --       fixAll = true,
    --       fixAllOnSave = true,
    --       organizeImports = true,
    --       organizeImportsOnSave = true,
    --       showSyntaxErrors = true,
    --       lint = {
    --         select ={
    --           "E4",
    --           "E7",
    --           "E9",
    --           "F",
    --           "I",
    --           "W",
    --           "ASYNC",
    --           "B",
    --           "A",
    --           "COM812",
    --           "C4",
    --           "PIE",
    --           "RSE",
    --           "RET5",
    --           "SIM",
    --           "ARG",
    --           "PTH",
    --           "PD",
    --           "PL",
    --           "TRY",
    --           "NPY",
    --           "LOG",
    --           "RUF",
    --         },
    --         ignore = {
    --           "RET501",
    --           "RET502",
    --           "W191",
    --           "E111",
    --           "E114",
    --           "E117",
    --           "E501",
    --           "D206",
    --           "D300",
    --           "Q000",
    --           "Q001",
    --           "Q002",
    --           "Q003",
    --           "COM812",
    --           "COM819",
    --           "ISC001",
    --           "ISC002",
    --           "TRY300",
    --           "F401",    -- remove unused imports
    --           "ANN101",  -- self type annotation
    --           "ANN102",  -- self type annotation
    --           "PLR2004", -- magic value in comparison
    --         },
    --       },
    --       codeAction = {
    --         disableRuleComment = {
    --           enable = true,
    --         },
    --         fixViolation = {
    --           enable = true,
    --         },
    --         lint = {
    --           enable = true,
    --           preview = false,
    --         },
    --         format = {
    --           enable = true,
    --           preview = false,
    --         },
    --       },
    --     },
    --   },
    -- })


    lspconfig.pylsp.setup({
      enabled = false,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            editorconfig = { enabled = false },
            basedpyright = { enabled = false },
            ruff = { enabled = true },
            pycodestyle = { enabled = false },
            pydocstyle = { enabled = false },
            pylint = { enabled = false },
            flake8 = { enabled = false },
            mypy = { enabled = false },
            yapf = { enabled = false },
            isort = { enabled = false },
            black = { enabled = false },
            jedi = { enabled = false },
            mccabe = { enabled = false },
            pyflakes = { enabled = false },
            bandit = { enabled = false },
            radon = { enabled = false },
            rope = { enabled = false },
            pyls_isort = { enabled = false },
            pyls_black = { enabled = false },
            pyls_mypy = { enabled = false },
            pyls_flake8 = { enabled = false },
            pyls_pycodestyle = { enabled = false },
            pyls_pydocstyle = { enabled = false },
            pyls_mccabe = { enabled = false },
            pyls_pyflakes = { enabled = false },
            pyls_bandit = { enabled = false },
            pyls_radon = { enabled = false },
            pyls_rope = { enabled = false },
            pyls_jedi = { enabled = false },
          },
        }
      }
    })


    lspconfig.basedpyright.setup({
      enabled = false,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        basedpyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            -- Ignore all files for analysis to exclusively use Ruff for linting
            ignore = { '*' },
          },
        },
      },
    })


    lspconfig.pyright.setup({
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
            ignore = { '*' },
          },
        },
      },
    })


    lspconfig.editorconfig_checker.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        python = {
            format = { enabled = false, },
            lint = { enabled = false, },
        }
      }
    })


    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    })


    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = { yaml = { schemas = {} } },
      filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    })


    lspconfig.azure_pipelines_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "yaml" },
    })


    lspconfig.omnisharp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      filetypes = { "cs", "csproj", "sln" },
    })


    lspconfig.csharp_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "cs", "csproj", "sln" },
    })


  end,
}
