local M = {}

local ui = require("config.ui")

--- Get an empty table of mappings with a key for each map mode
---@return table<string,table> # a table with entries for each map mode
function M.empty_map_table()
  local maps = {}
  for _, mode in ipairs({ "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" }) do
    maps[mode] = {}
  end
  if vim.fn.has("nvim-0.10.0") == 1 then
    for _, abbr_mode in ipairs({ "ia", "ca", "!a" }) do
      maps[abbr_mode] = {}
    end
  end
  return maps
end

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
  local was_no_which_key_queue = not M.which_key_queue
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd
        local keymap_opts = base or {}
        if type(options) == "string" or type(options) == "function" then
          cmd = options
        else
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd then -- if which-key mapping, queue it
          ---@cast keymap_opts wk.Spec
          keymap_opts[1], keymap_opts.mode = keymap, mode
          if not keymap_opts.group then keymap_opts.group = keymap_opts.desc end
          if not M.which_key_queue then M.which_key_queue = {} end
          table.insert(M.which_key_queue, keymap_opts)
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  if was_no_which_key_queue and M.which_key_queue then M.on_load("which-key.nvim", M.which_key_register) end
end

--- Get an icon from the UI icons if it is available and return it
---@param kind string The kind of icon in `ui.icons` to retrieve
---@param padding? integer Padding to add to the end of the icon
---@param no_fallback? boolean Whether or not to disable fallback to text icon
---@return string icon
function M.get_icon(kind, padding, no_fallback)
  local icons_enabled = vim.g.icons_enabled ~= false
  if not icons_enabled and no_fallback then return "" end
  local icon_pack = ui.icons
  local icon = icon_pack and icon_pack[kind]
  return icon and icon .. (" "):rep(padding or 0) or ""
end

local sections = {
  f = { desc = M.get_icon("Search", 1, true) .. "Find" },
  p = { desc = M.get_icon("Package", 1, true) .. "Packages" },
  l = { desc = M.get_icon("ActiveLSP", 1, true) .. "Language Tools" },
  u = { desc = M.get_icon("Window", 1, true) .. "UI/UX" },
  b = { desc = M.get_icon("Tab", 1, true) .. "Buffers" },
  bs = { desc = M.get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { desc = M.get_icon("Debugger", 1, true) .. "Debugger" },
  g = { desc = M.get_icon("Git", 1, true) .. "Git" },
  S = { desc = M.get_icon("Session", 1, true) .. "Session" },
  t = { desc = M.get_icon("Terminal", 1, true) .. "Terminal" },
  x = { desc = M.get_icon("List", 1, true) .. "Quickfix/Lists" },
}

-- Initialize mappings table
local maps = M.empty_map_table()

-- Normal --
-- Standard Operations
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Move cursor down" }
maps.x["j"] = maps.n["j"]
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Move cursor up" }
maps.x["k"] = maps.n["k"]
maps.n["<Leader>w"] = { "<Cmd>w<CR>", desc = "Save" }
maps.n["<Leader>q"] = { "<Cmd>confirm q<CR>", desc = "Quit Window" }
maps.n["<Leader>Q"] = { "<Cmd>confirm qall<CR>", desc = "Exit AstroNvim" }
maps.n["<Leader>n"] = { "<Cmd>enew<CR>", desc = "New File" }
maps.n["<C-S>"] = { "<Cmd>silent! update! | redraw<CR>", desc = "Force write" }
-- TODO: remove insert save in AstroNvim v5 when used for signature help
maps.i["<C-S>"] = { "<Esc>" .. maps.n["<C-S>"][1], desc = maps.n["<C-S>"].desc }
maps.x["<C-S>"] = maps.i["<C-S>"]
maps.n["<C-Q>"] = { "<Cmd>q!<CR>", desc = "Force quit" }
maps.n["|"] = { "<Cmd>vsplit<CR>", desc = "Vertical Split" }
maps.n["\\"] = { "<Cmd>split<CR>", desc = "Horizontal Split" }
-- TODO: remove deprecated method check after dropping support for neovim v0.9
if not vim.ui.open then
  local gx_desc = "Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)"
  maps.n["gx"] = { function() astro.system_open(vim.fn.expand("<cfile>")) end, desc = gx_desc }
  maps.x["gx"] = {
    function()
      local lines = vim.fn.getline("'<", "'>")
      astro.system_open(table.concat(vim.tbl_map(vim.trim, lines)))
    end,
    desc = gx_desc,
  }
end
maps.n["<Leader>/"] = { "gcc", remap = true, desc = "Toggle comment line" }
maps.x["<Leader>/"] = { "gc", remap = true, desc = "Toggle comment" }

-- Neovim Default LSP Mappings
if vim.fn.has("nvim-0.11") ~= 1 then
  maps.n["gra"] = { function() vim.lsp.buf.code_action() end, desc = "Code Action" }
  maps.x["gra"] = { function() vim.lsp.buf.code_action() end, desc = "Code Action" }
  maps.n["grn"] = { function() vim.lsp.buf.rename() end, desc = "Rename" }
  maps.n["grr"] = { function() vim.lsp.buf.references() end, desc = "References" }
  -- TODO: AstroNvim v5 add backwards compatibility to follow neovim 0.11 mappings
  -- maps.i["<C-S>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature Help" }
end

-- [Rest of your mappings...]

-- Set mappings in the module
M.mappings = maps

-- Setup function to register the keymaps
M.setup = function()
  local keymaps = M.mappings
  for mode, mappings in pairs(keymaps) do
    for key, mapping in pairs(mappings) do
      if mapping then
        if type(mapping) == "table" then
          local cmd = mapping[1]
          local opts = vim.tbl_extend("force", { noremap = true, silent = true }, mapping)
          opts[1] = nil -- Remove the command from the options table
          vim.keymap.set(mode, key, cmd, opts)
        else
          vim.keymap.set(mode, key, mapping, { noremap = true, silent = true })
        end
      end
    end
  end
end

return M

