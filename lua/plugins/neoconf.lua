-- lua/plugins/neoconf.lua

return {
  "folke/neoconf.nvim",
  cmd = "Neoconf",
  config = false,
  enabled = true,
  lazy = false,
  priority = 1000 -- Ensure this runs before other plugins
}
