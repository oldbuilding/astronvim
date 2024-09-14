return {
  "0xfraso/nvim-listchars",
  -- 🝙  🝚  🝐  ˺ ⁔  ˲  ⁞ ⁝  ˹˺ ⇢
  config = function()
    require("nvim-listchars").setup({
      save_state = false,
      listchars = {
        trail = "░",
        eol = "↲",
        tab = "»-",
        space = "·",
      },
      exclude_filetypes = {
        "markdown",
      },
      lighten_step = 15,
      notifications = false,
    })
  end,
}
