-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- require("neoconf").setup(),

  { "junegunn/vim-easy-align", command = "EasyAlign", lazy = true, enabled = true },
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
  -- == Examples of Adding Plugins ==
  {
    "tjdevries/vlog.nvim",
    event = "VeryLazy",
    enabled = true,
    config = function()
      vim.g.vlog_log_level = "debug"
      vim.g.vlog_use_file = false
      vim.g.vlog_highlights = true
      vim.g.vlog_use_console = true
    end,
  },
  {
    "nvim-neorg/neorg",
    opts = {},
  },
  {
    "goolord/alpha-nvim",
    -- dependencies = {
    --     "nvim-tree/nvim-web-devicons",
    --     "nvim-lua/plenary.nvim"
    -- },
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮",
        "┃▐███████████████████████████████████████████████▍┃",
        "┃▐██████████▛▔ █████████████████▒ ▔▜█████▔┉◖◖█▓▓▓▍┃",
        "┃▐██████████ ﬛   ██████████████░█   ▜█████▚▘█████▍┃",
        "┃▐██████████▙     ░███████████░      ▜███▚█▚█████▍┃",
        "┃▐█████████▓█  ╮ ░▒███████████░     ▖ ██▚████████▍┃",
        "┃▐███▓▓███▒██   █▒████████████╯   ╸╸▓▒███████████▍┃",
        "┃▐██▒▓▓▓█░███ █ █▌▞████████████ █▆▎▐█████████████▍┃",
        "┃▐██▒▒▓▓█████ █ ██████████████▛▐██▎▐█████████████▍┃",
        "┃▐█▒▒▒▓▓█████ ██▟▀██████████▛▍▟███ ██████████████▍┃",
        "╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯",
      }
      return opts
      -- ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▊ ▉ ▋ ▌ ▍ ▎ ▏ ▐ ░ ▒ ▓ ▔ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟
      -- ─ ━ │┃┄ ┅ ┆ ┇ ┈ ┉ ┊ ┋ ┌ ┍ ┎ ┏ ╭ ╮ ╯╰ ╱ ╲ ╳ ╴ ╵ ╶ ╷ ╸ ╹ ╺ ╻
      -- ═ ║ ╞ ╟ ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ╪ ╫ ╬
    end,
  },
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require("luasnip")
      luasnip.filetype_extend(
        "javascript",
        {
          "javascriptreact",
        },
        "typescript",
        {
          "typescriptreact",
        }
      )
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            :with_pair(cond.not_after_regex("%%"))
            :with_pair(
              -- don't add a pair if the next character is %
              -- don't add a pair if  the previous character is xxx
              cond.not_before_regex("xxx", 3)
            )
            :with_move(cond.none())
            :with_del(cond.not_after_regex("xx"))
            :with_cr(cond.none()),
          -- don't move right when repeat character
          -- don't delete if the next character is xx
          -- disable adding a newline when you press <cr>
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  -- -- lazy.nvim
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    enabled = false,
    config = function() require("lsp_signature").setup() end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    enabled = true,
    config = function() require("nvim-surround").setup({}) end,
  },
}
