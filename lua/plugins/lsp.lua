return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neoconf.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local ruff_on_attach = function(_, bufnr)
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      buf_set_option("shiftwidth", 4)
      buf_set_option("tabstop", 4)
      buf_set_option("expandtab", true)
    end
    local Paths = require("utils.paths")
    lspconfig.ruff.setup({
      on_attach = ruff_on_attach,
      init_options = {
        settings = {
          configuration = Paths.find_project_root() .. "/.ruff.toml",
          configurationPreference = "editorFirst", -- "filesystemFirst",
          linelength = 180,
          fixAll = true,
          fixAllOnSave = true,
          organizeImports = true,
          organizeImportsOnSave = true,
          showSyntaxErrors = true,
          lint = {
            select ={
              "E4",
              "E7",
              "E9",
              "F",
              "I",
              "W",
              "ASYNC",
              "B",
              "A",
              "COM812",
              "C4",
              "PIE",
              "RSE",
              "RET5",
              "SIM",
              "ARG",
              "PTH",
              "PD",
              "PL",
              "TRY",
              "NPY",
              "LOG",
              "RUF",
            },
            ignore = {
              "RET501",
              "RET502",
              "W191",
              "E111",
              "E114",
              "E117",
              "E501",
              "D206",
              "D300",
              "Q000",
              "Q001",
              "Q002",
              "Q003",
              "COM812",
              "COM819",
              "ISC001",
              "ISC002",
              "TRY300",
              "F401",    -- remove unused imports
              "ANN101",  -- self type annotation
              "ANN102",  -- self type annotation
              "PLR2004", -- magic value in comparison
            },
          },
          codeAction = {
            disableRuleComment = {
              enable = true,
            },
            fixViolation = {
              enable = true,
            },
            lint = {
              enable = true,
              preview = false,
            },
            format = {
              enable = true,
              preview = false,
            },
          },
        },
      },
    })

    lspconfig.pyright.setup({
      settings = {
        python = { analysis = { ignore = { "*" } } }
      }
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    })

    require("lspconfig").yamlls.setup({
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
