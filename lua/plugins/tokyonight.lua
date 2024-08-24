return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    light_style = "day",
    day_brightness = 0.99,
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = { bold = true },
      variables = { bold = true },
      sidebars = "transparent",
      floats = "dark",
    },
    dim_inactive = true,
    lualine_bold = true,
    cache = true,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
