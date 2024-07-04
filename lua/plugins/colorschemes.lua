return {
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
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  { "echasnovski/mini.base16", version = false },
}
