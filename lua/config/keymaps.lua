-- local keymap = vim.api.nvim_set_keymap
-- local opts = {noremap = true, silent = true}
-- keymap("n", ":", ";", opts)
-- keymap("n", "<M-t>", ":", opts)
-- keymap("n", ";", ":", opts)
-- return {
--     "AstroNvim/astrocore",
--     ---@type AstroCoreOpts
--     opts = {
--         mappings = {
--             n = {
--                 [";"] = {":", desc = "Invert ; :", noremap = true, silent = true},
--                 [":"] = {";", desc = "Invert : ;", noremap = true, silent = true}
--             },
--             i = {}
--         }
--     }
-- }

-- File: lua/user/config.lua

-- return {
--     -- Other custom configurations...

--     mappings = function()
--         local map = require("core.utils").map

--         -- Custom Normal Mode Mappings
--         map("n", "<M-<Del>>", "<Cmd>Q!<CR>", {desc = "Quit!"})

--         -- Additional mappings...
--     end

--     -- Other configurations...
-- }

-- local astro = require "astrocore"
-- local which_key = require("which-key")
-- local lazy = require("lazy")

-- -- Define your custom mappings function
-- local function setup_custom_mappings()
--     -- Custom mappings
--     local mappings = {
--         n = {
--             -- Normal mode mappings
--             ["<Leader>e"] = {"<Cmd>NvimTreeToggle<CR>", "Toggle Explorer"},
--             ["<Leader>f"] = {"<Cmd>Telescope find_files<CR>", "Find Files"}
--             -- Add more custom mappings here
--         },
--         v = {}
--     }

--     -- Register the mappings with which-key
--     which_key.register(mappings.n, {mode = "n"}) -- Normal mode
--     which_key.register(mappings.v, {mode = "v"}) -- Visual mode
-- end

-- -- Call the function to setup custom mappings
-- setup_custom_mappings()

-- -- Assuming `opts` and [`maps`](command:_github.copilot.openSymbolFromReferences?%5B%7B%22%24mid%22%3A1%2C%22path%22%3A%22%2FUsers%2Fmiguelmartin%2F.local%2Fshare%2Fastronvim%2Flazy%2FAstroNvim%2Flua%2Fastronvim%2Fplugins%2F_astrocore_mappings.lua%22%2C%22scheme%22%3A%22file%22%7D%2C%7B%22line%22%3A21%2C%22character%22%3A10%7D%5D "lazy/AstroNvim/lua/astronvim/plugins/_astrocore_mappings.lua") are accessible or have been initialized similarly
-- -- Add or modify sections as needed
-- opts._map_sections["c"] = {desc = "Custom Commands"}

-- -- Override the <C-Q> mapping to close the current buffer instead of force quitting
-- maps.n["<C-Q>"] = {"<Cmd>bd!<CR>", desc = "Close buffer"}

-- -- Register the custom mappings (hypothetical function, adjust based on actual AstroNvim API)
-- astro.register_mappings(maps)
