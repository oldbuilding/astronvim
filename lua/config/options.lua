local M = {}

local transparency_amount = 33 -- 0 opaque to 100 transparent
local update_time_ms = 300 -- save swap file and trigger CursorHold
local keymap_sequence_timeout_ms = 250 -- time (ms) to wait for a mapped sequence to complete (default 1000)
local spell_util = require("utils.spell")
local spellfile_path, spellfile_name = spell_util.get_spell_directory_and_filename()

M._get_vim_global_opts = function()
  return {
    guifont = { "VictorMonoNerdFontMono", ":h16" },
    mapleader = ",", -- Set space as the leader key
    maplocalleader = " ", -- Set local leader key
    -- python3_host_prog = '/path/to/python3',  -- Register Python 3 for Neovim
    eof = true,
    fixeof = true,
    eol = true,
    fixeol = true,
  }
end

M._get_vim_opts = function()
  return {
    -- vim.opt.<key>
    spell = true, -- sets vim.opt.spell
    spellfile = spellfile_path .. spellfile_name,
    spelllang = { "en_us" },
    spelloptions = "camel",
    autowrite = true,
    bomb = false,
    binary = false,
    cmdheight = 0,
    clipboard = "unnamedplus", -- Use system clipboard
    colorcolumn = "156",
    conceallevel = 3,
    confirm = true,
    copyindent = true,
    cursorline = true,
    diffopt = "linematch:50",
    dir = "/tmp",
    directory = "~/.cache/" .. os.getenv("NVIM_APPNAME") .. "/swaps/",
    expandtab = true,
    fileencoding = "utf-8",
    fileencodings = "utf-8",
    foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value,
    foldenable = true,
    foldcolumn = "0",
    foldlevelstart = 99,
    foldmethod = "indent",
    formatoptions = "jcroqlnt",
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --vimgrep",
    guifont = { "VictorMonoNerdFontMono", ":h16" },
    -- guifont = "VictorMono NF:h17",
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
    -- listchars = "space:·,tab:▓|,trail:░,nbsp:_,extends:>,precedes:<,eol:⁝",
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
    undodir = "~/.cache/" .. os.getenv("NVIM_APPNAME") .. "/undo/",
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
    wildignore = table.concat({
      "bin",
      "obj",
      ".pie",
      "__pycache__",
      "node_modules",
      "blue.vim",
      "darkblue.vim",
      "default.vim",
      "delek.vim",
      "desert.vim",
      "elflord.vim",
      "evening.vim",
      "industry.vim",
      "koehler.vim",
      "lunaperche.vim",
      "morning.vim",
      "murphy.vim",
      "pablo.vim",
      "peachpuff.vim",
      "ron.vim",
      "shine.vim",
      "slate.vim",
      "sorbet.vim",
      "torte.vim",
      "wildcharm.vim",
      "zellner.vim",
      "vim.vim",
    }, ","),
    winblend = 0, -- (0 == opaque) ; floating window transparency,
    winminwidth = 10,
    winwidth = 30,
    wrap = false,
    writebackup = false,
  }
end

M.setup = function()
  local g = M._get_vim_global_opts()
  for k, v in pairs(g) do
    vim.g[k] = v
  end
  local opt = M._get_vim_opts()
  for k, v in pairs(opt) do
    vim.opt[k] = v
  end
end

return M
