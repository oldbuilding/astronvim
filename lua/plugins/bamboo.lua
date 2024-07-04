return -- Using lazy.nvim
{
  "ribru17/bamboo.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- optional configuration here
    style = "light",
    transparent = true,
    dim_inactive = true,
    term_colors = false,
    diagnostics = {
      darker = true, -- darker colors for diagnostics
      undercurl = true, -- rather than underline
      background = true, -- for virtual text
    },
  },
  config = function()
    require("bamboo").setup(opts)
    require("bamboo").load()
  end,
}
