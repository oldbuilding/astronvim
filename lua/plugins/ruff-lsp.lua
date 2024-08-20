if true then return {} end

---@type LazySpec
return {
  "astral-sh/ruff-lsp",
  enable = false,
  -- Configure `ruff-lsp`.
  -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
  -- For the default config, along with instructions on how to customize the settings
  require("lspconfig").ruff_lsp.setup {
    init_options = {
      settings = {
        fixAll = true,
        organizeImports = true,
        -- Any extra CLI arguments for `ruff` go here.
        args = {
          "--config", "~/.config/ruff/ruff.toml"
        },
      },
    },
  },
  require("lspconfig").pyright.setup {
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { "*" },
        },
      },
    },
  },
}
