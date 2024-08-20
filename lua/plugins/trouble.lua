return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  enable = false,
  opts = {
    auto_close = true, -- auto close when there are no items
    auto_open = false, -- auto open when there are items
    auto_preview = false, -- automatically open preview when on an item
    auto_refresh = true, -- auto refresh when open
    auto_jump = true, -- auto jump to the item when there's only one
    focus = true, -- Focus the window when opened
    restore = true, -- restores the last location in the list when opening
    follow = true, -- Follow the current item
    indent_guides = true, -- show indent guides
    max_items = 100, -- limit number of items that can be displayed per section
    multiline = true, -- render multi-line messages
    pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
    warn_no_results = false, -- show a warning when there are no results
    open_no_results = false, -- open the trouble window when there are no results
    relative = "cursor",
    win = {
      type = "split",
      position = "bottom",
      padding = { top = 1, left = 1 },
      bo = {
        bufhidden = "wipe",
        filetype = "Trouble",
        buftype = "nofile",
      },
      wo = {
        cursorcolumn = false,
        cursorline = true,
        cursorlineopt = "both",
        fillchars = "eob: ",
        list = true,
        number = true,
        relativenumber = true,
        signcolumn = "no",
        spell = false,
        winbar = "",
        winblend = 0,
        statuscolumn = "",
        winfixheight = true,
        winfixwidth = false,
        winhighlight = "Normal:TroubleNormal,NormalNC:TroubleNormalNC,EndOfBuffer:TroubleNormal",
        wrap = false,
      },
    }, -- window options for the results window. Can be a split or a floating window.
    -- Window options for the preview window. Can be a split, floating window,
    -- or `main` to show the preview in the main editor window.
    preview = {
      -- main, split, or float
      type = "float",
      -- when a buffer is not yet loaded, the preview window will be created
      -- in a scratch buffer with only syntax highlighting enabled.
      -- Set to false, if you want the preview to always be a real loaded buffer.
      scratch = true,
      relative = "cursor",
      auto_open = false,
      auto_preview = false,
      auto_close = true,
    },
    -- Throttle/Debounce settings. Should usually not be changed.
    throttle = {
      refresh = 20, -- fetches new data when needed
      update = 10, -- updates the window
      render = 10, -- renders the window
      follow = 100, -- follows the current item
      preview = { ms = 100, debounce = true }, -- shows the preview for the current item
    },
    -- Key mappings can be set to the name of a builtin action,
    -- or you can define your own custom action.
    keys = {
      ["?"] = "help",
      r = "refresh",
      R = "toggle_refresh",
      q = "close",
      o = "jump_close",
      ["<esc>"] = "cancel",
      ["<cr>"] = "jump",
      ["<2-leftmouse>"] = "jump",
      ["<c-s>"] = "jump_split",
      ["<c-v>"] = "jump_vsplit",
      -- go down to next item (accepts count)
      -- j = "next",
      ["}"] = "next",
      ["]]"] = "next",
      -- go up to prev item (accepts count)
      -- k = "prev",
      ["{"] = "prev",
      ["[["] = "prev",
      dd = "delete",
      d = { action = "delete", mode = "v" },
      i = "inspect",
      p = "preview",
      P = "toggle_preview",
      zo = "fold_open",
      zO = "fold_open_recursive",
      zc = "fold_close",
      zC = "fold_close_recursive",
      za = "fold_toggle",
      zA = "fold_toggle_recursive",
      zm = "fold_more",
      zM = "fold_close_all",
      zr = "fold_reduce",
      zR = "fold_open_all",
      zx = "fold_update",
      zX = "fold_update_all",
      zn = "fold_disable",
      zN = "fold_enable",
      zi = "fold_toggle_enable",
      gb = { -- example of a custom action that toggles the active view filter
        action = function(view) view:filter({ buf = 0 }, { toggle = true }) end,
        desc = "Toggle Current Buffer Filter",
      },
      s = { -- example of a custom action that toggles the severity
        action = function(view)
          local f = view:get_filter("severity")
          local severity = ((f and f.filter.severity or 0) + 1) % 5
          view:filter({ severity = severity }, {
            id = "severity",
            template = "{hl:Title}Filter:{hl} {severity}",
            del = severity == 0,
          })
        end,
        desc = "Toggle Severity Filter",
      },
    },
    modes = {
      diagnostics = {
        desc = "Diagnostics",
        auto_open = false,
        auto_close = true,
        auto_preview = false,
        focus = true,
        win = {
          type = "split",
          position = "bottom",
        },
      },
      cascade = {
        -- This mode shows only the most severe diagnostics.
        -- Once those are resolved, less severe diagnostics will be shown.
        mode = "diagnostics", -- inherit from diagnostics mode
        auto_open = false,
        auto_preview = false,
        auto_close = true,
        focus = true,
        filter = {
          any = {
            buf = 0,
            {
              function(items)
                local severity = vim.diagnostic.severity.HINT
                for _, item in ipairs(items) do
                  severity = math.min(severity, item.severity)
                end
                return vim.tbl_filter(function(item) return item.severity == severity end, items)
              end,
            },
          },
        },
        win = {
          type = "split",
          position = "bottom",
        },
      },
      buffer_and_all_errors = {
        mode = "diagnostics", -- inherit from diagnostics mode
        auto_open = false,
        auto_preview = false,
        auto_close = true,
        focus = true,
        filter = {
          any = {
            buf = 0, {
              severity = vim.diagnostic.severity.ERROR,
              function(item)
                -- limit items to the current project
                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
              end,
            },
          },
        },
        win = {
          type = "split",
          position = "right",
        },
      },
      lsp_references = {
        -- some modes are configurable, see the source code for more details
        auto_open = false, -- auto open when there are items
        auto_preview = false, -- automatically open preview when on an item
        auto_close = true,
        focus = false,
        position = "bottom",
        type = "split",
        params = { include_declaration = true, },
      },
      -- The LSP base mode for:
      -- * lsp_definitions, lsp_references, lsp_implementations
      -- * lsp_type_definitions, lsp_declarations, lsp_command
      lsp_base = {
        auto_open = false, -- auto open when there are items
        auto_preview = false, -- automatically open preview when on an item
        auto_close = true,
        focus = false,
        type = "split",
        position = "bottom",
        params = {
          -- don't include the current location in the results
          include_current = false,
        },
      },
      -- more advanced example that extends the lsp_document_symbols
      symbols = {
        desc = "Symbols",
        mode = "lsp_document_symbols",
        auto_open = false,
        auto_preview = false,
        auto_close = true,
        focus = true,
        position = "right",
        type = "split",
        filter = {
          -- remove Package since lua_ls uses it for control flow structures
          ["not"] = { ft = "lua", kind = "Package" },
          any = {
            -- all symbol kinds for help / markdown files
            ft = { "help", "markdown" },
            -- default set of symbol kinds
            kind = {
              "Class",
              "Constructor",
              "Enum",
              "Field",
              "Function",
              "Interface",
              "Method",
              "Module",
              "Namespace",
              "Package",
              "Property",
              "Struct",
              "Trait",
            },
          },
        },
      },
    },
  -- stylua: ignore
  icons = {
    indent = {
      top           = "│ ",
      middle        = "├╴",
      last          = "╰╴",
      fold_open     = " ",
      fold_closed   = " ",
      ws            = "  ",
    },
    folder_closed   = " ",
    folder_open     = " ",
    kinds = {
      Array         = " ",
      Boolean       = "󰨙 ",
      Class         = " ",
      Constant      = "󰏿 ",
      Constructor   = " ",
      Enum          = " ",
      EnumMember    = " ",
      Event         = " ",
      Field         = " ",
      File          = " ",
      Function      = "󰊕 ",
      Interface     = " ",
      Key           = " ",
      Method        = "󰊕 ",
      Module        = " ",
      Namespace     = "󰦮 ",
      Null          = " ",
      Number        = "󰎠 ",
      Object        = " ",
      Operator      = " ",
      Package       = " ",
      Property      = " ",
      String        = " ",
      Struct        = "󰆼 ",
      TypeParameter = " ",
      Variable      = "󰀫 ",
    },
  },
  },
  keys = {
    -- WHICH-KEY DESCRIPTIONS
    {
      "<Leader>x",
      desc = "Trouble",
    },
    {
      "<Leader>xx",
      desc = "Additional Trouble",
    },
    {
      "<Leader>xs",
      desc = "Document Symbols",
    },
    {
      "<Leader>xd",
      desc = "Diagnostics",
    },
    -- DIAGNOSTICS
    ["<Leader>xl"] = false,
    ["<Leader>xq"] = false,
    ["<Leader>xtf"] = false,
    ["<Leader>xtp"] = false,
    ["<Leader>xtn"] = false,
    {
      "<Leader>xda",
      "<Cmd>Trouble diagnostics " ..
        "win.wo.winfixwidth=true<CR>",
      desc = "All Diagnostics",
    },
    {
      "<Leader>xdd",
      "<Cmd>Trouble buffer_and_all_errors " ..
        "win.wo.winfixwidth=true<CR>",
      desc = "Buffer+All Errors Diagnostics",
    },
    {
      "<Leader>xdD",
      "<Cmd>Trouble focus=true " ..
        "win.wo.winfixwidth=true<CR>",
      desc = "Focus on Diagnostics",
    },
    {
      "<Leader>xdp",
      "<Cmd>Trouble buffer_and_all_errors prev " ..
        "win.wo.winfixwidth=true<CR>",
      desc = "Prev Diagnostic",
    },
    {
      "<Leader>xdn",
      "<Cmd>Trouble buffer_and_all_errors next " ..
        "win.wo.winfixwidth=true " ..
        "auto_close=true " ..
        "focus=true<CR>",
      desc = "Next Diagnostic",
    },
    -- SYMBOLS
    {
      "<Leader>xss",
      "<Cmd>Trouble lsp_document_symbols " ..
        "focus=true " ..
        "auto_jump=true " ..
        "win.position=right " ..
        "win.wo.winfixwidth=true " ..
        "auto_close=false " ..
        "auto_refresh=true<CR>",
      desc = "Document Symbols (Focus)",
    },
    {
      "<Leader>xsS",
      "<Cmd>Trouble lsp_document_symbols " ..
        "focus=false " ..
        "win.position=bottom<CR>",
      desc = "Document Symbols",
    },
    {
      "<Leader>xsp",
      "<Cmd>Trouble lsp_document_symbols prev<CR>",
      desc = "Prev Symbol",
    },
    {
      "<Leader>xsn",
      "<Cmd>Trouble lsp_document_symbols next<CR>",
      desc = "Next Symbol",
    },
    -- LSP DEFINITIONS
    {
      "<Leader>xxd",
      "<Cmd>Trouble lsp toggle " ..
        "focus=false " ..
        "auto_jump=true " ..
        "win.position=right " ..
        "win.wo.winfixwidth=true " ..
        "focus=true " ..
        "auto_refresh=true " ..
        "auto_close=true<CR>",
      desc = "LSP Definitions",
    },
    -- LOCATION LIST / QUICKFIX LIST
    {
      "<Leader>xxl",
      "<Cmd>Trouble loclist toggle " ..
        "focus=false " ..
        "auto_jump=true " ..
        "win.position=right " ..
        "win.wo.winfixwidth=true " ..
        "focus=true " ..
        "auto_refresh=true " ..
        "auto_close=true<CR>",
      desc = "Location List (Trouble)",
    },
    {
      "<Leader>xxf",
      "<Cmd>Trouble qflist toggle " ..
        "focus=false " ..
        "auto_jump=true " ..
        "win.position=right " ..
        "win.wo.winfixwidth=true " ..
        "focus=true " ..
        "auto_refresh=true " ..
        "auto_close=true<CR>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
