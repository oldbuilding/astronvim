-- lua/plugins/neoconf.lua

return {
  "folke/neoconf.nvim",
  cmd = "Neoconf",
  config = false,
  enabled = true,
  lazy = true,
  priority = 1000 -- Ensure this runs before other plugins
}
