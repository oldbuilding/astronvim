-- lua/lsp/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")
    local methods = require("null-ls.methods")
    local paths = require("utils.paths")

    -- local ruff_linter = helpers.make_builtin({
    --   name = "ruff",
    --   method = methods.internal.DIAGNOSTICS,
    --   filetypes = { "python" },
    --   generator_opts = {
    --     command = paths.get_mason_bin() .. "/ruff",
    --     args = { "check", "--stdin-filename", "$FILENAME", "--format", "json", "-" },
    --     to_stdin = true,
    --     format = "json",
    --     on_output = helpers.diagnostics.from_json({
    --       severities = {
    --         ["E"] = helpers.diagnostics.severities.error,
    --         ["W"] = helpers.diagnostics.severities.warning,
    --         ["F"] = helpers.diagnostics.severities.information,
    --       },
    --     }),
    --   },
    --   factory = helpers.generator_factory,
    -- })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.py",
      callback = function() vim.lsp.buf.format({ async = true }) end,
    })

    local ruff_formatter = helpers.make_builtin({
      name = "ruff",
      method = methods.internal.FORMATTING,
      filetypes = { "python" },
      generator_opts = {
        command = "ruff",
        args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
        to_stdin = true,
      },
      factory = helpers.formatter_factory,
    })

    local fixjson_formatter = helpers.make_builtin({
      name = "fixjson",
      method = methods.internal.FORMATTING,
      filetypes = { "json" },
      generator_opts = {
        command = paths.get_mason_bin() .. "/fixjson",
        args = { "--stdin-filename", "$FILENAME", "-" },
        to_stdin = true,
      },
      factory = helpers.formatter_factory,
    })

    null_ls.setup({
      sources = {
        --
        -- DIAGNOSTICS / LINTERS
        --
        -- custom sources --
        --
        -- quick_lint_js,
        -- ruff_linter,
        -- luacheck_diagnostic,

        null_ls.builtins.diagnostics.credo,

        null_ls.builtins.diagnostics.editorconfig_checker.with({
          command = "editorconfig-checker",
          args = { "--config", paths.get_editorconfig_path() },
        }),

        null_ls.builtins.diagnostics.commitlint.with({
          command = paths.get_mason_bin() .. "/commitlint",
        }),

        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.selene,
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.yamllint,
        --
        -- FORMATTERS
        -- eslint_d_formatter,
        fixjson_formatter,
        ruff_formatter,
        -- ts_standard_formatter,

        null_ls.builtins.formatting.stylua,

        null_ls.builtins.formatting.clang_format.with({
          command = paths.get_mason_bin() .. "/clang_format",
        }),

        null_ls.builtins.formatting.prettierd.with({
          command = paths.get_mason_bin() .. "/prettierd",
          extra_args = {
            "--no-semi",
            "--double-quotes",
            "--prose-wrap",
            "always",
          },
          filetypes = { "yaml", "json" },
        }),

        -- null_ls.builtins.formatting.stylelint.with({
        -- command = paths.get_mason_bin() .. "/stylelint"
        -- }),

        -- null_ls.builtins.formatting.shfmt.with({
        -- command = paths.get_mason_bin() .. "shfmt"
        -- }),

        -- null_ls.builtins.formatting.shellharden.with({
        -- command = paths.get_brew_bin() .. "/shellharden"
        -- }),

        -- null_ls.builtins.formatting.stylua.with({
        -- command = paths.get_mason_bin() .. "/stylua"
        -- }),

        -- null_ls.builtins.formatting.yamlfix.with({
        -- command = paths.get_mason_bin() .. "/yamlfix"
        -- }),
      },
    })
  end,
}
-- local quick_lint_js = helpers.make_builtin({
--   name = "quick-lint-js",
--   method = methods.internal.DIAGNOSTICS,
--   filetypes = { "javascript", "typescript" },
--   generator_opts = {
--     command = paths.get_mason_bin() .. "/quick-lint-js",
--     args = { "--stdin", "--stdin-filename", "$FILENAME" },
--     to_stdin = true,
--     format = "line",
--     on_output = helpers.diagnostics.from_pattern(
--       [[(.*):(%d+):(%d+): (.*)]],
--       { "severity", "row", "col", "message" },
--       { severities = { ["error"] = 1, ["warning"] = 2 } }
--     ),
--   },
--   factory = helpers.generator_factory,
-- })

-- local eslint_d_formatter = helpers.make_builtin({
--   name = "eslint_d",
--   method = methods.internal.FORMATTING,
--   filetypes = { "javascript", "typescript" },
--  generator_opts = {
--     command = paths.get_mason_bin() .. "/eslint_d",
--     args = { "--stdin", "--stdin-filename", "$FILENAME", "--fix-to-stdout" },
--     to_stdin = true,
--   },
--   factory = helpers.formatter_factory,
-- })

-- local ts_standard_formatter = require("null-ls.helpers").make_builtin({
--   name = "ts-standard",
--   method = require("null-ls.methods").internal.FORMATTING,
--   filetypes = { "typescript" },
--   generator_opts = {
--       command = "ts-standard",
--       args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
--       to_stdin = true,
--   },
--   factory = require("null-ls.helpers").formatter_factory,
-- })
--
-- local luacheck_diagnostic = helpers.make_builtin({
--   name = "luacheck",
--   method = methods.internal.DIAGNOSTICS,
--   filetypes = { "lua" },
--   generator_opts = {
--     command = paths.get_mason_bin() .. "/luacheck",
--     args = { "--formatter", "plain", "--codes", "--ranges", "--no-color", "-" },
--     to_stdin = true,
--     from_stderr = false,
--     format = "line",
--     on_output = helpers.diagnostics.from_pattern(
--       [[(%d+):(%d+)-(%d+): %(([^%)]*)%) (.*)]],
--       { "row", "col", "end_col", "code", "message" },
--       { severities = { ["W"] = helpers.diagnostics.severities.warning, ["E"] = helpers.diagnostics.severities.error, } }
--     ),
--   },
--   factory = helpers.generator_factory,
-- })
