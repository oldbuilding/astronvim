if true then return {} end

if vim.g.vscode then return {} end

local mappings = require("utils.keymaps").get_keymaps()
local paths = require("utils.paths")

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      -- autopairs_enabled = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      -- diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
      -- mine
      mapleader = ",", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      -- diagnostics visibility:
      -- -- 0=off,
      -- -- 1=only show in status line, r=virtual text off 3=all on
      diagnostics_mode = 3,
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      lsp_handlers_enabled = true,
      python3_host_prog = paths.get_python3_host_prog(),
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      g = require("utils.options").get_vim_global_opts(),
      opt = require("utils.options").get_vim_opts(),
    },
    mappings = mappings,
  },
}
