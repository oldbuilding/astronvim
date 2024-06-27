-- lua/plugins/neoconf.lua

return {
  "folke/neoconf.nvim",
  config = function()
    require("neoconf").setup()
  end,
  priority = 1000, -- Ensure this runs before other plugins
}
