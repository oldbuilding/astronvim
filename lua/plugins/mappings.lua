return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        [";"] = { ":", desc = "; :", noremap = true, silent = true },
        [":"] = { ";", desc = ": ;", noremap = true, silent = true },
      },
      i = {},
    }
  }
}
