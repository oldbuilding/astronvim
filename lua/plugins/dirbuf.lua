return {
  "elihunter173/dirbuf.nvim",
  lazy = true,
  enabled = true,
  opts = function()
    return {
      hash_padding = 2,
      show_hidden = true,
      sort_order = "default",
      write_cmd = "DirbufSync",
    }
  end,
  config = function(_, opts) require("dirbuf").setup(opts) end,
}
