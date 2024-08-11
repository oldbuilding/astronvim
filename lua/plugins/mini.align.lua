return {
  "echasnovski/mini.align",
  version = false,
  lazy = true,
  silent = false, -- Whether to disable showing non-error feedback
  mappings = {
    -- Module mappings. Use `''` (empty string) to disable one.
    start = "gA",
    start_with_preview = "ga",
  },

  config = function()
    -- Default options controlling alignment process
    require("mini.align").setup({
      split_pattern = "",
      justify_side = "left",
      merge_delimiter = "",
    })
  end,

  -- Default steps performing alignment (if `nil`, default is used)
  steps = {
    pre_split = {},
    split = nil,
    pre_justify = {},
    justify = nil,
    pre_merge = {},
    merge = nil,
  },
}
