-- lua/plugins/neoconf.lua

return {
  "folke/neoconf.nvim",
  config = false,
  enabled = true,
  lazy = false,
  cmd = "Neoconf",
  priority = 1000 -- Ensure this runs before other plugins
}
