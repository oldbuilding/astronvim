return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neoconf.nvim",
  },
  config = function()
    -- require("neoconf").setup() -- Ensure neoconf is setup here if needed
    local lspconfig = require("lspconfig")

    lspconfig.ruff_lsp.setup({
      on_attach = function(_, bufnr)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_option("shiftwidth", 4)
        buf_set_option("tabstop", 4)
        buf_set_option("expandtab", true)
      end,
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
