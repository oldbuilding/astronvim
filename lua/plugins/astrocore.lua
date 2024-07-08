-- don't do anything in vscode instances
-- if vim.g.vscode then
--   return {}
-- end


local transparency_amount = 0 -- 0 opaque to 100 transparent
local update_time_ms = 300 -- save swap file and trigger CursorHold
local keymap_sequence_timeout_ms = 400 -- time (ms) to wait for a mapped sequence to complete (default 1000)
local spell_util = require("utils.spell")
local spellfile_path, spellfile_name = spell_util.get_spell_directory_and_filename()

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      -- diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
      -- mine
      mapleader = ",", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off 3=all on)
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      lsp_handlers_enabled = true,
      python3_host_prog = os.getenv("brewpythonpath"),
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        -- vim.opt.<key>
        spell = true, -- sets vim.opt.spell
        spellfile = spellfile_path .. spellfile_name,
        spelllang = { "en_us" },
        spelloptions = "camel",
        autowrite = true,
        cmdheight = 0,
        conceallevel = 3,
        confirm = true,
        copyindent = true,
        cursorline = true,
        diffopt = "linematch:50",
        dir = "/tmp",
        directory = "~/.config/" .. os.getenv("NVIM_APPNAME") .. "/swaps/",
        expandtab = true,
        fileencoding = "utf-8",
        foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value,
        foldenable = true,
        foldcolumn = "0",
        foldlevelstart = 99,
        foldmethod = "indent",
        formatoptions = "jcroqlnt",
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --vimgrep",
        guifont = "VictorMono NF:h17",
        hidden = true,
        history = 10000,
        hlsearch = true,
        ignorecase = true,
        inccommand = "split", -- preview replacements,
        incsearch = true,
        infercase = true,
        joinspaces = false, -- no double spacing when joining,
        jumpoptions = "view",
        laststatus = 2,
        lazyredraw = false,
        linebreak = true,
        list = true, -- show some invisible chars,
        listchars = "tab: .,trail:~,nbsp:_,extends:>,precedes:<", -- ,eol:$',
        magic = true,
        matchtime = 2, -- tenths of a second before matching (){}[] is highlighted
        mouse = "a",
        number = true,
        numberwidth = 4,
        pumblend = transparency_amount, -- popup win transparency,
        pumheight = 15, -- max items in popup,
        relativenumber = true,
        ruler = false,
        scroll = 20,
        scrolloff = 25, -- lines of context,
        sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "folds" },
        shiftround = true,
        shiftwidth = 2,
        showbreak = "↳ ",
        showcmd = false,
        showmatch = true,
        showmode = false, -- don't display current mode,
        showtabline = 0,
        sidescrolloff = 15, -- columns of context,
        signcolumn = "yes:1",
        smartcase = true,
        smartindent = true,
        smarttab = true,
        softtabstop = -1,
        splitbelow = true, -- Put new windows below current,
        splitkeep = "screen",
        splitright = true, -- Put new windows right of current,
        swapfile = false,
        syntax = "on",
        tabstop = 2,
        textwidth = 100,
        timeoutlen = keymap_sequence_timeout_ms, -- time (ms) to wait for a mapped sequence to complete (default 1000),
        ttimeoutlen = 50, -- time (ms) to wait for a key code sequence to complete (default 50),
        undodir = vim.fn.stdpath("config") .. "/undo",
        undofile = true,
        undolevels = 10000,
        undoreload = 10000,
        updatetime = update_time_ms,
        visualbell = false,
        whichwrap = "h,l,<,>,[,],~",
        wildchar = ("\t"):byte(), -- initiates wildcard expansion in terminal,
        wildmenu = true,
        wildmode = "longest:full,full", -- cli completion mode,
        wildoptions = "pum",
        winblend = transparency_amount, -- floating window transparency,
        winminwidth = 10,
        winwidth = 30,
        wrap = false,
        writebackup = false,
      },
      g = {},
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      -- second key is the lefthand side of the map
      n = {
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
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {},
    },
  },
}
