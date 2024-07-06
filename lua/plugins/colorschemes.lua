return {
  -- {
  --   "lrangell/theme-cycler.nvim",
  --   ---@param opts table
  --   opts = function(_, opts)
  --     require("theme-cycler").setup(opts)
  --
  --     -- Register keymaps with which-key
  --     local wk = require("which-key")
  --     wk.register({
  --       ["<Leader>tc"] = { "<cmd>CycleTheme<CR>", "Cycle Theme" },
  --       ["<Leader>tn"] = { "<cmd>CycleThemeNext<CR>", "Next Theme" },
  --       ["<Leader>tp"] = { "<cmd>CycleThemePrev<CR>", "Previous Theme" },
  --     }, { mode = "n" })
  --   end,
  -- },
  {
    "Verf/deepwhite.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        theme = "deepwhite",
        low_blue_light = true,
      }
    end,
    config = function(_, opts)
      require("deepwhite").setup(opts)
      vim.cmd.colorscheme("deepwhite")
    end,
  },
  { "savq/melange-nvim" },
  { "SebastianZaha/nvim-solar-paper" },
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  { "echasnovski/mini.base16", version = false },
}
