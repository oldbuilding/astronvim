return {
  "nvimtools/none-ls.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          extra_args = {
            "--no-semi",
            "--double-quotes",
            "--prose-wrap",
            "always",
          },
          filetypes = { "yaml", "json" },
        }),

        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.yamllint,
      },
    })
  end,
}
