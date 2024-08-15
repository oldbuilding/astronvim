local M = {}

M.get_keymaps = function()
  local spell_util = require("utils.spell")
  -- NOTE keycodes follow the casing in the vimdocs.
  -- For example,
  -- `<Leader>` must be capitalized
  local mappings = {
    n = {
      ["<Leader>o"] = false,
      [",o"] = false,
      ["<Leader>e"] = false,
      [",e"] = false,
      --
      --
      ["<Leader>w"] = { "<Cmd>wall<CR>", desc = "Write all" },
      --
      -- ["<Leader>-"] = { "<Cmd>Oil --float<CR>", desc = "Oil - Open parent directory" },
      --
      -- Jump to previous position with Alt-b
      ["<M-h>"] = { "<Cmd>normal! <C-o><CR>", desc = "Jump to previous position" },
      -- Jump to next position with Alt-m
      ["<M-n>"] = { "<Cmd>normal! <C-i><CR>", desc = "Jump to next position" },
      --
      ["<M-t>"] = { desc = "+Neotree" },
      ["<M-t>b"] = { "<Cmd>Neotree float buffers<CR>", desc = "Explorer Buffers" },
      ["<M-t>d"] = { "<Cmd>Neotree float document_symbols<CR>", desc = "Document Symbols Explorer" },
      ["<M-t>e"] = { "<Cmd>Neotree toggle<CR>", desc = "Explorer Toggle" },
      ["<M-t>g"] = { "<Cmd>Neotree float git_status<CR>", desc = "Git Status Explorer" },
      ["<M-t><M-t>"] = { "<Cmd>Neotree reveal<CR>", desc = "Explorer Focus (current buffer)" },
      --
      ["<Leader><Leader>d"] = { "<Cmd>g/^$/d<CR>", desc = "Delete empty lines" },
      --
      -- disable the default Exit AstroNvim mapping
      ["<Leader>Q"] = false,
      ["<Leader><M-x>"] = { "<Cmd>confirm qall<CR>", desc = "Exit AstroNvim" },
      -- swap ; and :
      [";"] = { ":", desc = "Invert ; :", noremap = true, silent = true },
      [":"] = { ";", desc = "Invert : ;", noremap = true, silent = true },
      -- ["<M-t>"] = {":", desc = ":", noremap = true, silent = true},
      -- navigate buffer tabs with `H` and `L`
      L = {
        function() require("astrocore.buffer").nav(vim.v.count1) end,
        desc = "Next buffer",
      },
      H = {
        function() require("astrocore.buffer").nav(-vim.v.count1) end,
        desc = "Previous buffer",
      },
      -- mappings seen under group name "Buffer"
      ["<Leader>bD"] = {
        function()
          require("astroui.status.heirline").buffer_picker(
            function(bufnr) require("astrocore.buffer").close(bufnr) end
          )
        end,
        desc = "Pick to close",
      },
      -- tables with just a `desc` key will be registered with which-key if it's installed
      -- this is useful for naming menus
      ["<Leader>b"] = { desc = "Buffers" },

      ["<Leader>Lne"] = {
        function() require("noice").cmd("errors") end,
        desc = "Noice Errors",
      },
      ["<Leader>La"] = {
        function() require("noice").cmd("all") end,
        desc = "Noice All",
      },
      ["<Leader>Ll"] = {
        function() require("noice").cmd("log") end,
        desc = "Noice Log",
      },
      ["<Leader>LD"] = {
        function() require("noice").cmd("disable") end,
        desc = "Noice Disable",
      },
      ["<Leader>LE"] = {
        function() require("noice").cmd("enable") end,
        desc = "Noice Enable",
      },
      ["<Leader>Lt"] = {
        function() require("noice").cmd("telescope") end,
        desc = "Noice Telescope",
      },
      ["<Leader>L."] = {
        function() require("noice").cmd("last") end,
        desc = "Noice Last",
      },
      ["<Leader>Lh"] = {
        function() require("noice").cmd("history") end,
        desc = "Noice History",
      },
      ["<Leader>Lx"] = {
        function() require("noice").cmd("dismiss") end,
        desc = "Noice Clear All",
      },
      ["<Leader>Lm"] = {
        "<Cmd>messages<CR>",
        desc = "Show Messages",
      },
      ["<Leader>L-"] = {
        "<Cmd>messages clear<CR>",
        desc = "Clear Messages",
      },
      ["<Leader>L"] = { desc = "Logs" },
      ["<Leader>xS"] = {
        function() spell_util.rebuild_spell_binary() end,
        desc = "Rebuild Spell Binary",
      },
    },
    t = {},
  }
  return mappings
end

return M

