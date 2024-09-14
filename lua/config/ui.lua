local M = {}

-- don't do anything in vscode instances
if vim.g.vscode then return {} end

-- -- AstroUI provides the basis for configuring the AstroNvim User Interface
-- -- Configuration documentation can be found with `:h astroui`
-- -- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
-- --       as this provides autocomplete and documentation while editing

-- ---@type LazySpec
-- return {
--   "AstroNvim/astroui",
--   ---@type AstroUIOpts
--   opts = {
--     -- change colorscheme
--     colorscheme = "astromars",
--     -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
--     highlights = {
--       init = { -- this table overrides highlights in all themes
--         -- Normal = { bg = "#000000" },
--       },
--       astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
--         -- Normal = { bg = "#000000" },
--       },
--     },
--     -- Icons can be configured throughout the interface
--     icons = {
--       -- configure the loading of the lsp in the status line
--       LSPLoading1 = "⠋",
--       LSPLoading2 = "⠙",
--       LSPLoading3 = "⠹",
--       LSPLoading4 = "⠸",
--       LSPLoading5 = "⠼",
--       LSPLoading6 = "⠴",
--       LSPLoading7 = "⠦",
--       LSPLoading8 = "⠧",
--       LSPLoading9 = "⠇",
--       LSPLoading10 = "⠏",
--     },
--   },
-- }

M.opts = function()
  return {
    colorscheme = "astrotheme",
    icons = {
      ActiveLSP = "",
      ActiveTS = "",
      ArrowLeft = "",
      ArrowRight = "",
      Bookmarks = "",
      BufferClose = "󰅖",
      DapBreakpoint = "",
      DapBreakpointCondition = "",
      DapBreakpointRejected = "",
      DapLogPoint = "󰛿",
      DapStopped = "󰁕",
      Debugger = "",
      DefaultFile = "󰈙",
      Diagnostic = "󰒡",
      DiagnosticError = "",
      DiagnosticHint = "󰌵",
      DiagnosticInfo = "󰋼",
      DiagnosticWarn = "",
      Ellipsis = "…",
      Environment = "",
      FileNew = "",
      FileModified = "",
      FileReadOnly = "",
      FoldClosed = "",
      FoldOpened = "",
      FoldSeparator = " ",
      FolderClosed = "",
      FolderEmpty = "",
      FolderOpen = "",
      Git = "󰊢",
      GitAdd = "",
      GitBranch = "",
      GitChange = "",
      GitConflict = "",
      GitDelete = "",
      GitIgnored = "◌",
      GitRenamed = "➜",
      GitSign = "▎",
      GitStaged = "✓",
      GitUnstaged = "✗",
      GitUntracked = "★",
      List = "",
      LSPLoading1 = "",
      LSPLoading2 = "󰀚",
      LSPLoading3 = "",
      MacroRecording = "",
      Package = "󰏖",
      Paste = "󰅌",
      Refresh = "",
      Search = "",
      Selected = "❯",
      Session = "󱂬",
      Sort = "󰒺",
      Spellcheck = "󰓆",
      Tab = "󰓩",
      TabClose = "󰅙",
      Terminal = "",
      Window = "",
      WordFile = "󰈭",
    },
    text_icons = {
      ActiveLSP = "LSP:",
      ArrowLeft = "<",
      ArrowRight = ">",
      BufferClose = "x",
      DapBreakpoint = "B",
      DapBreakpointCondition = "C",
      DapBreakpointRejected = "R",
      DapLogPoint = "L",
      DapStopped = ">",
      DefaultFile = "[F]",
      DiagnosticError = "X",
      DiagnosticHint = "?",
      DiagnosticInfo = "i",
      DiagnosticWarn = "!",
      Ellipsis = "...",
      Environment = "Env:",
      FileModified = "*",
      FileReadOnly = "[lock]",
      FoldClosed = "+",
      FoldOpened = "-",
      FoldSeparator = " ",
      FolderClosed = "[D]",
      FolderEmpty = "[E]",
      FolderOpen = "[O]",
      GitAdd = "[+]",
      GitChange = "[/]",
      GitConflict = "[!]",
      GitDelete = "[-]",
      GitIgnored = "[I]",
      GitRenamed = "[R]",
      GitSign = "|",
      GitStaged = "[S]",
      GitUnstaged = "[U]",
      GitUntracked = "[?]",
      MacroRecording = "Recording:",
      Paste = "[PASTE]",
      Search = "?",
      Selected = "*",
      Spellcheck = "[SPELL]",
      TabClose = "X",
    },
  }
end

return M
