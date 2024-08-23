return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neoconf.nvim",
  },
  config = function()
    -- require("neoconf").setup() -- Ensure neoconf is setup here if needed
    local lspconfig = require("lspconfig")

    lspconfig.ruff.setup({
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

    lspconfig.pylsp.setup({
      enabled = false,
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
      settings = {
        pyright = {
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

    lspconfig.editorconfig_checker.setup({
      settings = {
        python = {
            format = { enabled = false, },
            lint = { enabled = false, },
        }
      }
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    })

    lspconfig.yamlls.setup({
      settings = { yaml = { schemas = {} } },
      filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    })
    --
    -- Separate configuration for azure-pipelines-ls
    --
    lspconfig.azure_pipelines_ls.setup({
      filetypes = { "yaml" },
    })

    lspconfig.omnisharp.setup({
      cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      filetypes = { "cs", "csproj", "sln" },
      -- root_dir = lspconfig.util.root_pattern(".git", "*.sln"),
      -- capabilities = require("astronvim.utils.lsp").capabilities(),
      -- on_attach = require("astronvim.utils.lsp").on_attach(),
    })

    lspconfig.csharp_ls.setup({
      filetypes = { "cs", "csproj", "sln" },
      -- root_dir = lspconfig.util.root_pattern(".git", "*.sln"),
      -- capabilities = require("astronvim.utils.lsp").capabilities(),
      -- on_attach = require("astronvim.utils.lsp").on_attach(),
    })

  end,
}
