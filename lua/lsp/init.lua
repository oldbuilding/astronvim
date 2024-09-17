-- lua/lsp/init.lua
--
local M = {}

-- Import each LSP-related config file
M.setup = function()
  require("lsp.mason") -- Mason setup
  require("lsp.lsp-config") -- LSP config setup
  -- require("lsp.dap")         -- DAP setup
  require("lsp.none-ls") -- null-ls setup
  require("lsp.lines") -- lsp-lines setup
  require("lsp.signature") -- lsp-signature setup
end

return M

-- if true then return {} end
-- local M = {}
-- local Util = require("utils")
-- local plugins = {}
--
-- local base = vim.fn.stdpath("config") -- default: $XDG_CONFIG_HOME/nvim (i.e. `.config/nvim`)
-- local files = Util.scandir(base .. "/lua/plugins/lsp", "init*") -- ignores init.lua
--
-- for _, v in ipairs(files) do
--   local module = string.sub(v, 1, #v - #".lua") -- e.g. `lsp_lines.lua`  ==> `lsp_lines`
--   table.insert(plugins, module)
-- end
--
-- for _, v in ipairs(plugins) do
--   local status_ok, plug = pcall(require, "plugins.lsp." .. v)
--   if not status_ok then return end
--   table.insert(M, plug)
-- end
--
-- return M
