-- if true then return {} end

return {
  {
    "junegunn/vim-easy-align",
    command = "EasyAlign",
    lazy = true,
    enabled = true,
  },
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
  -- {
  --   "nvim-neorg/neorg",
  --   opts = {},
  -- },
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
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
  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup({}) end,
  },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require("luasnip")
  --     luasnip.filetype_extend(
  --       "javascript",
  --       {
  --         "javascriptreact",
  --       },
  --       "typescript",
  --       {
  --         "typescriptreact",
  --       }
  --     )
  --   end,
  -- },
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
