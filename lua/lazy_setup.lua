require("lazy").setup({
  -- Mason setup should be early in the configuration
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = {
    colorscheme = {
      "falcon",
      "night-owl",
      "rose-pine",
      "oh-lucy",
      "tokyonight",
      "kangawa",
      "bamboo",
    },
  },
  colorscheme = "falcon",
  background = "dark",
  ui = { backdrop = 60, border = "rounded" },
  checker = { enabled = true },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "man",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "osc52",
        "rplugin",
        "rrhelper",
        "shada",
        "spec",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
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
