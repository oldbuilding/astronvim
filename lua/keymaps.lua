return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        mappings = {
            n = {
                [";"] = { ":", desc = "Invert ; :", noremap = true, silent = true },
                [":"] = { ";", desc = "Invert : ;", noremap = true, silent = true },
            },
            i = {},
        }
    }
}
