return {
  "Leviathenn/nvim-transparent",
  lazy = false,
  priority = 1000,
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
      },
      exclude = {}, -- table: groups you don't want to clear
    })
  end
}
