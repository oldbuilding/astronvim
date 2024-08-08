return {
  {
    "folke/which-key.nvim",
    opts = {
      win = {
        -- width = 99,
        -- height = 23,
        row = math.huge,
        col = 0,
        border = "single",
        no_overlap = true,
        padding = { 2, 3 }, -- extra window padding [top/bottom, left/right]
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = {
          winblend = 0,
        },
      },
      layout = {
        height = { min = 10, max = 42 }, -- min and max height of the columns
        width = { min = 23, max = 133 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "right", -- align columns left, center or right
        position = "center",
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      sort = { "local" },
      show_keys = true,
      presets = {
        name = "modern",
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  },
}
