-- lua/lsp/lsp.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local Paths = require("utils.paths")
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    capabilities.textDocument.completion.completionItem.snippetSupport = true

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
            bandit = { enabled = false },
            black = { enabled = false, maxLineLength = 133 },
            basedpyright = { enabled = false, maxLineLength = 133 },
            isort = { enabled = false, maxLineLength = 133 },
            pycodestyle = { enabled = false, maxLineLength = 133 },
            pydocstyle = { enabled = false, maxLineLength = 133 },
            pylint = { enabled = false, maxLineLength = 133 },
            pyflakes = { enabled = false, maxLineLength = 133 },
            ruff = { enabled = true, maxLineLength = 133 },
            flake8 = { enabled = false },
            mypy = { enabled = false },
            jedi = { enabled = false },
            mccabe = { enabled = false },
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
            radon = { enabled = false },
            rope = { enabled = false },
            yapf = { enabled = false },
          },
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
  end,
}
