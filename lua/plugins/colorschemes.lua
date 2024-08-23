return {
  -- {
  --   "lrangell/theme-cycler.nvim",
  --   ---@param opts table
  --   opts = function(_, opts)
  --     require("theme-cycler").setup(opts)
  --
  --     -- Register keymaps with which-key
  --     local wk = require("which-key")
  --     wk.register({
  --       ["<Leader>tc"] = { "<cmd>CycleTheme<CR>", "Cycle Theme" },
  --       ["<Leader>tn"] = { "<cmd>CycleThemeNext<CR>", "Next Theme" },
  --       ["<Leader>tp"] = { "<cmd>CycleThemePrev<CR>", "Previous Theme" },
  --     }, { mode = "n" })
  --   end,
  -- },
  {

    "ofirgall/ofirkai.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("ofirkai").setup({
        theme = "dark_blue", -- Choose theme to use, available themes: 'dark_blue'
        scheme = require("ofirkai").scheme, -- Option to override scheme
        custom_hlgroups = {}, -- Option to add/override highlight groups
        remove_italics = false, -- Option to change all the italics style to none
      })
    end,
  },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      require("lackluster").setup({
        tweak_ui = {
          disable_undercurl = true, -- set to true if you want underline instead of undercurl
          enable_end_of_buffer = true, -- set to true to show the end_of_buffer ~ symbols in the gutter
        },
        vim.cmd.colorscheme("lackluster"),
      })
    end,
  },
  {
    "Yazeed1s/oh-lucy.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "fenetikm/falcon",
    lazy = false,
    priority = 1000,
    falcon_background = 0,
    falcon_inactive = 1,
    -- config = function(_, _)
    --   require("falcon").setup({
    --   })
    -- end,
  },
  {
    "oxfist/night-owl.nvim",
    version = false,
    config = function(_, _)
      require("night-owl").setup({
        bold = true,
        italics = true,
        underline = true,
        undercurl = true,
        transparent_background = true,
        vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = "Blue" }),
      })
    end,
  },
  {

    "ray-x/starry.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("starry").setup({
        border = false, -- Split window borders
        hide_eob = false, -- Hide end of buffer
        italics = {
          comments = true, -- Italic comments
          strings = false, -- Italic strings
          keywords = false, -- Italic keywords
          functions = false, -- Italic functions
          variables = false, -- Italic variables
        },
        contrast = { -- Select which windows get the contrast background
          enable = true, -- Enable contrast
          terminal = true, -- Darker terminal
          filetypes = { "*" }, -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
        },
        text_contrast = {
          lighter = true, -- Higher contrast text for lighter style
          darker = true, -- Higher contrast text for darker style
        },
        disable = {
          background = false, -- true: transparent background
          term_colors = false, -- Disable setting the terminal colors
          eob_lines = false, -- Make end-of-buffer lines invisible
        },
        style = {
          name = "middlenight_blue", -- other theme styles:
          -- -- earliestsummer
          -- -- moonlight
          -- -- dracula
          -- -- oceanic
          -- -- 'dracula_blood'
          -- -- 'deep ocean'
          -- -- darker
          -- -- palenight
          -- -- monokai
          -- -- mariana
          -- -- emerald
          -- -- 'middlenight_blue'
          disable = {}, -- a list of styles to disable, e.g. {'bold', 'underline'}
          fix = true,
          darker_contrast = true, -- More contrast for darker style
          daylight_switch = false, -- Enable day and night style switching
          deep_black = true, -- Enable a deeper black background
        },
        custom_colors = {
          variable = "#f797d7",
        },
        custom_highlights = {
          LineNr = { fg = "#777777" },
          Idnetifier = { fg = "#ff4797" },
        },
      })
    end,
  },
  {
    "Verf/deepwhite.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        theme = "deepwhite",
        low_blue_light = true,
      }
    end,
    config = function(_, opts)
      require("deepwhite").setup(opts)
      vim.cmd.colorscheme("deepwhite")
    end,
  },
  { "savq/melange-nvim" },
  { "SebastianZaha/nvim-solar-paper" },
  {
    "nyoom-engineering/oxocarbon.nvim",
  },
  { "echasnovski/mini.base16", version = false },
  { "rose-pine/neovim", version = false },
  { "xero/miasma.nvim", version = false },
  { "navarasu/onedark.nvim", version = false },
  { "sontungexpt/witch", version = false },
  { "Th3Whit3Wolf/one-nvim", version = false },
}
