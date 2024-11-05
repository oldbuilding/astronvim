local M = {}

M.get_keymaps = function()
  local spell_util = require("utils.spell")
  -- NOTE keycodes follow the casing in the vimdocs.
  -- For example,
  -- `<Leader>` must be capitalized
  local mappings = {
    n = {
      { "<Leader>o", false },
      { ",o", false },
      { "<Leader>e", false },
      { ",e", false },
      --
      { "<Leader>w", "<Cmd>wall<CR>", desc = "Write all" },
      --
      { "<Leader><Leader>", desc = "Etc" },
      --
      -- Jump to previous position with Alt-b
      { "<M-h>", "<Cmd>normal! <C-o><CR>", desc = "Jump to previous position" },
      -- Jump to next position with Alt-m
      { "<M-n>", "<Cmd>normal! <C-i><CR>", desc = "Jump to next position" },
      --
      { "<M-t>", desc = "+Neotree" },
      { "<M-t>b", "<Cmd>Neotree float buffers<CR>", desc = "Explorer Buffers" },
      { "<M-t>d", "<Cmd>Neotree float document_symbols<CR>", desc = "Document Symbols Explorer" },
      { "<M-t>e", "<Cmd>Neotree toggle<CR>", desc = "Explorer Toggle" },
      { "<M-t>g", "<Cmd>Neotree float git_status<CR>", desc = "Git Status Explorer" },
      { "<M-t><M-t>", "<Cmd>Neotree reveal<CR>", desc = "Explorer Focus (current buffer)" },
      --
      { "<Leader><Leader>d", "<Cmd>g/^$/d<CR>", desc = "Delete empty lines" },
      --
      -- Disable the default Exit AstroNvim mapping
      { "<Leader>Q", false },
      { "<Leader><M-x>", "<Cmd>confirm qall<CR>", desc = "Exit AstroNvim" },
      -- Swap ; and :
      { ";", ":", desc = "Invert ; :", noremap = true, silent = true },
      { ":", ";", desc = "Invert : ;", noremap = true, silent = true },
      -- Navigate buffer tabs with `H` and `L`
      { "H", function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
      { "L", function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
      -- Mappings seen under group name "Buffer"
      {
        "<Leader>bD",
        function()
          require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
        end,
        desc = "Pick to close",
      },
      -- Tables with just a `desc` key will be registered with which-key if it's installed
      -- This is useful for naming menus
      ["<Leader>b"] = { desc = "Buffers" },

      -- Noice commands for log management
      { "<Leader>Lne", function() require("noice").cmd("errors") end, desc = "Noice Errors" },
      { "<Leader>La", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<Leader>Ll", function() require("noice").cmd("log") end, desc = "Noice Log" },
      { "<Leader>LD", function() require("noice").cmd("disable") end, desc = "Noice Disable" },
      { "<Leader>LE", function() require("noice").cmd("enable") end, desc = "Noice Enable" },
      { "<Leader>Lt", function() require("noice").cmd("telescope") end, desc = "Noice Telescope" },
      { "<Leader>L.", function() require("noice").cmd("last") end, desc = "Noice Last" },
      { "<Leader>Lh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<Leader>Lx", function() require("noice").cmd("dismiss") end, desc = "Noice Clear All" },
      { "<Leader>Lm", "<Cmd>messages<CR>", desc = "Show Messages" },
      { "<Leader>L-", "<Cmd>messages clear<CR>", desc = "Clear Messages" },
      { "<Leader>L", desc = "Logs" },
      { "<Leader>xS", {
        function() spell_util.rebuild_spell_binary() end,
        desc = "Rebuild Spell Binary",
      } },
    },
    t = {},
  }
  return mappings
end

-- Set mappings directly using Neovim's API
M.setup = function()
  local which_key_present, which_key = pcall(require, "which-key")

  for mode, mode_mappings in pairs(M.get_keymaps()) do
    for _, map in ipairs(mode_mappings) do
      if map and (type(map[2]) == "string" or type(map[2]) == "function") then
        -- Set the keymap using vim.keymap.set
        vim.keymap.set(mode, map[1], map[2], { expr = map.expr, silent = map.silent, desc = map.desc })

        -- Register with which-key if present
        if which_key_present and map.desc then which_key.register({ [map[1]] = map.desc }, { mode = mode }) end
      end
    end
  end
end

return M
