-- set vim options here (vim.<first_key>.<second_key> = value)
local transparency_amount = 0 -- 0 opaque to 100 transparent
local update_time_ms = 300 -- save swap file and trigger CursorHold
local keymap_sequence_timeout_ms = 400 -- time (ms) to wait for a mapped sequence to complete (default 1000)

return {
  g = {
    mapleader = ",", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 1, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    lsp_handlers_enabled = true,
    python3_host_prog = os.getenv("brewpythonpath"),
  },
  opt = {
    -- set to true or false etc.
    spell = true, -- sets vim.opt.spell
    spellfile = "~/.config/" .. os.getenv("NVIM_APPNAME") .. "/spell/en.utf-8.add",
    spelllang = { "en_us" },
    spelloptions = "camel",
    autowrite = true,
    autoindent = true,
    background = "dark",
    cmdheight = 0,
    conceallevel = 3,
    confirm = true,
    copyindent = true,
    cursorline = true,
    diffopt = "linematch:50",
    dir = "/tmp",
    directory = "~/.config/" .. os.getenv("NVIM_APPNAME") .. "/swaps/",
    expandtab = true,
    eol = true,
    fileencoding = "utf-8",
    fileformat = "unix",
    fixendofline = true,
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
    listchars = "tab:. ,trail:~,nbsp:_,extends:>,precedes:<", -- ,eol:$',
    magic = true,
    matchtime = 2, -- tenths of a second before matching (){}[] is highlighted
    mouse = "a",
    -- mousehide = true,
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
    shiftwidth = 0,
    -- shortmess:append { W = true, I = true, c = true },
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
    softtabstop = 0, -- 0 for tabstop's width (2); -1 for shiftwidth's width (0)
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
}
