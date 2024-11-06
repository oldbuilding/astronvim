---@type LazySpec
return {
  "astral-sh/ruff-lsp",
  enabled = true,  -- Enable Ruff LSP
  config = function()
    local lspconfig = require("lspconfig")

    -- Setup Ruff LSP
    lspconfig.ruff.setup({
      init_options = {
        settings = {
          fixAll = true,
          organizeImports = true,
          -- Any extra CLI arguments for `ruff` go here.
          args = {
            "--config",
            "~/.config/ruff/ruff.toml",
          },
        },
      },
    })

    -- Setup Pyright LSP to work with Ruff
    lspconfig.pyright.setup({
      settings = {
        pyright = {
          disableOrganizeImports = true,  -- Using Ruff's import organizer
        },
        python = {
          analysis = {
            ignore = { "*" },  -- Ignore all files for analysis to exclusively use Ruff for linting
          },
        },
      },
    })
  end,
}

