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
  f = { group = M.get_icon("Search", 1, true) .. "Find" },
  p = { group = M.get_icon("Package", 1, true) .. "Packages" },
  l = { group = M.get_icon("ActiveLSP", 1, true) .. "Language Tools" },
  u = { group = M.get_icon("Window", 1, true) .. "UI/UX" },
  b = { group = M.get_icon("Tab", 1, true) .. "Buffers" },
  bs = { group = M.get_icon("Sort", 1, true) .. "Sort Buffers" },
  d = { group = M.get_icon("Debugger", 1, true) .. "Debugger" },
  g = { group = M.get_icon("Git", 1, true) .. "Git" },
  S = { group = M.get_icon("Session", 1, true) .. "Session" },
  t = { group = M.get_icon("Terminal", 1, true) .. "Terminal" },
  x = { group = M.get_icon("List", 1, true) .. "Quickfix/Lists" },
}

-- Initialize mappings table
local maps = M.empty_map_table()

-- Normal --
-- Standard Operations
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Move cursor down" }
maps.x["j"] = maps.n["j"]
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Move cursor up" }
maps.x["k"] = maps.n["k"]
maps.n["<Leader>w"] = { "<Cmd>wall<CR>", desc = "Save All" }
maps.n["<Leader>q"] = { "<Cmd>confirm q<CR>", desc = "Quit Window" }
maps.n["<Leader><M-x>"] = { "<Cmd>confirm wall<CR><Cmd>confirm qall!<CR>", desc = "Exit Neovim" }
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

-- Plugin Manager
---
maps.n["<Leader>p"] = vim.tbl_get(sections, "p")
---
maps.n["<Leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<Leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<Leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<Leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<Leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }
maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Update Lazy and Mason" }

-- Manage Buffers
maps.n["<Leader>c"] = { function() require("utils.astrocore.buffer").close() end, desc = "Close buffer" }
maps.n["<Leader>C"] = { function() require("utils.astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
maps.n["]b"] = {
  function() require("utils.astrocore.buffer").nav(vim.v.count1) end,
  desc = "Next buffer",
}
maps.n["[b"] = {
  function() require("utils.astrocore.buffer").nav(-vim.v.count1) end,
  desc = "Previous buffer",
}
maps.n[">b"] = {
  function() require("utils.astrocore.buffer").move(vim.v.count1) end,
  desc = "Move buffer tab right",
}
maps.n["<b"] = {
  function() require("utils.astrocore.buffer").move(-vim.v.count1) end,
  desc = "Move buffer tab left",
}

---
maps.n["<Leader>b"] = vim.tbl_get(sections, "b")
---
maps.n["<Leader>bc"] = { function() require("utils.astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
maps.n["<Leader>bC"] = { function() require("utils.astrocore.buffer").close_all() end, desc = "Close all buffers" }
maps.n["<Leader>bl"] = { function() require("utils.astrocore.buffer").close_left() end, desc = "Close all buffers to the left" }
maps.n["<Leader>bp"] = { function() require("utils.astrocore.buffer").prev() end, desc = "Previous buffer" }
maps.n["<Leader>br"] = { function() require("utils.astrocore.buffer").close_right() end, desc = "Close all buffers to the right" }
---
maps.n["<Leader>bs"] = vim.tbl_get(sections, "bs")
---
maps.n["<Leader>bse"] = { function() require("utils.astrocore.buffer").sort("extension") end, desc = "By extension" }
maps.n["<Leader>bsr"] = { function() require("utils.astrocore.buffer").sort("unique_path") end, desc = "By relative path" }
maps.n["<Leader>bsp"] = { function() require("utils.astrocore.buffer").sort("full_path") end, desc = "By full path" }
maps.n["<Leader>bsi"] = { function() require("utils.astrocore.buffer").sort("bufnr") end, desc = "By buffer number" }
maps.n["<Leader>bsm"] = { function() require("utils.astrocore.buffer").sort("modified") end, desc = "By modification" }

---
maps.n["<Leader>l"] = vim.tbl_get(sections, "l")
---
maps.n["<Leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
local function diagnostic_goto(dir, severity)
  local go = vim.diagnostic["goto_" .. (dir and "next" or "prev")]
  if type(severity) == "string" then severity = vim.diagnostic.severity[severity] end
  return function() go({ severity = severity }) end
end
-- TODO: Remove mapping after dropping support for Neovim v0.10, it's automatic
if vim.fn.has("nvim-0.11") == 0 then
  maps.n["[d"] = { diagnostic_goto(false), desc = "Previous diagnostic" }
  maps.n["]d"] = { diagnostic_goto(true), desc = "Next diagnostic" }
end
maps.n["[e"] = { diagnostic_goto(false, "ERROR"), desc = "Previous error" }
maps.n["]e"] = { diagnostic_goto(true, "ERROR"), desc = "Next error" }
maps.n["[w"] = { diagnostic_goto(false, "WARN"), desc = "Previous warning" }
maps.n["]w"] = { diagnostic_goto(true, "WARN"), desc = "Next warning" }
-- TODO: Remove mapping after dropping support for Neovim v0.9, it's automatic
if vim.fn.has("nvim-0.10") == 0 then
  maps.n["<C-W>d"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
  maps.n["<C-W><C-D>"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
end
maps.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }

-- Navigate tabs
maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

-- Split navigation
maps.n["<C-H>"] = { "<C-w>h", desc = "Move to left split" }
maps.n["<C-J>"] = { "<C-w>j", desc = "Move to below split" }
maps.n["<C-K>"] = { "<C-w>k", desc = "Move to above split" }
maps.n["<C-L>"] = { "<C-w>l", desc = "Move to right split" }
maps.n["<C-Up>"] = { "<Cmd>resize -2<CR>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<Cmd>resize +2<CR>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<Cmd>vertical resize -2<CR>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<Cmd>vertical resize +2<CR>", desc = "Resize split right" }

-- List management
---
maps.n["<Leader>x"] = vim.tbl_get(sections, "x")
---
maps.n["<Leader>xq"] = { "<Cmd>copen<CR>", desc = "Quickfix List" }
maps.n["<Leader>xl"] = { "<Cmd>lopen<CR>", desc = "Location List" }
maps.n["]q"] = { vim.cmd.cnext, desc = "Next quickfix" }
maps.n["[q"] = { vim.cmd.cprev, desc = "Previous quickfix" }
maps.n["]Q"] = { vim.cmd.clast, desc = "End quickfix" }
maps.n["[Q"] = { vim.cmd.cfirst, desc = "Beginning quickfix" }

maps.n["]l"] = { vim.cmd.lnext, desc = "Next loclist" }
maps.n["[l"] = { vim.cmd.lprev, desc = "Previous loclist" }
maps.n["]L"] = { vim.cmd.llast, desc = "End loclist" }
maps.n["[L"] = { vim.cmd.lfirst, desc = "Beginning loclist" }

-- Stay in indent mode
maps.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }
maps.v["<Tab>"] = { ">gv", desc = "Indent line" }

-- Improved Terminal Navigation
local function term_nav(dir)
  return function()
    if vim.api.nvim_win_get_config(0).zindex then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-" .. dir .. ">", true, false, true), "n", false)
    else
      vim.cmd.wincmd(dir)
    end
  end
end
maps.t["<C-H>"] = { term_nav("h"), desc = "Terminal left window navigation" }
maps.t["<C-J>"] = { term_nav("j"), desc = "Terminal down window navigation" }
maps.t["<C-K>"] = { term_nav("k"), desc = "Terminal up window navigation" }
maps.t["<C-L>"] = { term_nav("l"), desc = "Terminal right window navigation" }

---
maps.n["<Leader>u"] = vim.tbl_get(sections, "u")
---
-- Custom menu for modification of the user experience
maps.n["<Leader>uA"] = { function() require("utils.astrocore.toggles").autochdir() end, desc = "Toggle rooter autochdir" }
maps.n["<Leader>ub"] = { function() require("utils.astrocore.toggles").background() end, desc = "Toggle background" }
maps.n["<Leader>ud"] = { function() require("utils.astrocore.toggles").diagnostics() end, desc = "Toggle diagnostics" }
maps.n["<Leader>ug"] = { function() require("utils.astrocore.toggles").signcolumn() end, desc = "Toggle signcolumn" }
maps.n["<Leader>u>"] = { function() require("utils.astrocore.toggles").foldcolumn() end, desc = "Toggle foldcolumn" }
maps.n["<Leader>ui"] = { function() require("utils.astrocore.toggles").indent() end, desc = "Change indent setting" }
maps.n["<Leader>ul"] = { function() require("utils.astrocore.toggles").statusline() end, desc = "Toggle statusline" }
maps.n["<Leader>un"] = { function() require("utils.astrocore.toggles").number() end, desc = "Change line numbering" }
maps.n["<Leader>uN"] = { function() require("utils.astrocore.toggles").notifications() end, desc = "Toggle Notifications" }
maps.n["<Leader>up"] = { function() require("utils.astrocore.toggles").paste() end, desc = "Toggle paste mode" }
maps.n["<Leader>us"] = { function() require("utils.astrocore.toggles").spell() end, desc = "Toggle spellcheck" }
maps.n["<Leader>uS"] = { function() require("utils.astrocore.toggles").conceal() end, desc = "Toggle conceal" }
maps.n["<Leader>ut"] = { function() require("utils.astrocore.toggles").tabline() end, desc = "Toggle tabline" }
maps.n["<Leader>uu"] = { function() require("utils.astrocore.toggles").url_match() end, desc = "Toggle URL highlight" }
maps.n["<Leader>uw"] = { function() require("utils.astrocore.toggles").wrap() end, desc = "Toggle wrap" }
maps.n["<Leader>uy"] = { function() require("utils.astrocore.toggles").buffer_syntax() end, desc = "Toggle syntax highlight" }

-- Set mappings in the module
M.mappings = maps

-- Setup function to register the keymaps
M.setup = function()
  local keymaps = M.mappings
  require("utils.astrocore").set_mappings(keymaps)
end

return M
