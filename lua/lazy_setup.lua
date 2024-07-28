-- Set the correct hererocks path
local hererocks_path = os.getenv("HOME") .. "/.local/pipx/venvs/hererocks"
local brewopt_path = os.getenv("brewopt")

-- Update Lua and Luarocks paths
package.path = package.path
  .. ";"
  .. hererocks_path
  .. "/share/lua/5.1/?.lua;"
  .. hererocks_path
  .. "/share/lua/5.1/?/init.lua;"
package.cpath = package.cpath .. ";" .. hererocks_path .. "/lib/lua/5.1/?.so;"

-- Function to set environment variables for Neovim
local function set_environment_vars()
  vim.env.LUA_PATH = hererocks_path .. "/share/lua/5.1/?.lua;" .. hererocks_path .. "/share/lua/5.1/?/init.lua;;"
  vim.env.LUA_CPATH = hererocks_path .. "/lib/lua/5.1/?.so;;"
  vim.env.PATH = hererocks_path .. "/bin:" .. vim.env.PATH
  if brewopt_path == nil or brewopt_path == "" then brewopt_path = "/home/linuxbrew/.linuxbrew/opt" end
  local git_exec_path = brewopt_path .. "/git/libexec/git-core"
  vim.env.GIT_EXEC_PATH = git_exec_path
end

require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    -- version = "^4", -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = {
      -- AstroNvim options must be set here with the `import` key
      mapleader = ",", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
      rocks = {
        enabled = true,
        hererocks = true,
      },
    },
    config = function() set_environment_vars() end,
  },
  { import = "community" },
  { import = "plugins" },
  -- { import = "lazyvim.plugins.extras.coding.copilot" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = {
    colorscheme = {
      "night-owl",
      "tokyonight",
      "kangawa",
      "mini.base16",
      "bamboo",
      "oxocarbon",
      "astromars",
      "habamax",
      "rose-pine",
    },
  },
  colorscheme = "night-owl", -- "kanagawa-wave",
  ui = { backdrop = 60, border = "rounded" },
  checker = { enabled = true },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
  pkg = {
    enabled = true,
    cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
    -- the first package source that is found for a plugin will be used.
    sources = {
      "lazy",
      "rockspec", -- will only be used when rocks.enabled is true
      "packspec",
    },
  },
  rocks = {
    enabled = true,
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
  },
} --[[@as LazyConfig]])
