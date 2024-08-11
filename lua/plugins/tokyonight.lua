return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "day",
    light_style = "day",
    day_brightness = 0.99,
    transparent = false,
    terminal_colors = false,
    styles = {},
    dim_inactive = true,
    lualine_bold = false,
    cache = true,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
