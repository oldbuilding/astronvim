return {
  "folke/flash.nvim",
  event = "VeryLazy",

  ---@type Flash.Config
  opts = {
    continue = true,
    labels = "asdfghjkwertyuiopzxcvbnm",
    search = {
      -- search/jump in all windows
      multi_window = true,
      -- search direction
      forward = true,
      -- when `false`, find only matches in the given direction
      wrap = true,
      ---@type Flash.Pattern.Mode
      mode = "exact", -- exact, fuzzy, search
      -- behave like `incsearch`
      incremental = false,
      -- Excluded filetypes and custom window filters
      ---@type (string|fun(win:window))[]
      exclude = {
        -- "noice",
        "notify",
        "cmp_menu",
        "flash_prompt",
        function(win)
          -- exclude non-focusable windows
          return not vim.api.nvim_win_get_config(win).focusable
        end,
      },
    },
    jump = {
      -- save location in the jumplist
      jumplist = true,
      -- jump position
      pos = "start", ---@type "start" | "end" | "range"
      -- add pattern to search history
      history = false,
      -- add pattern to search register
      register = false,
      -- clear highlight after jump
      nohlsearch = false,
      -- automatically jump when there is only one match
      autojump = false,
    },
    label = {
      -- allow uppercase labels
      uppercase = true,
      -- add any labels with the correct case here, that you want to exclude
      exclude = "",
      -- add a label for the first match in the current window.
      -- you can always jump to the first match with `<CR>`
      current = true,
      -- show the label after the match
      after = true, ---@type boolean|number[]
      -- show the label before the match
      before = false, ---@type boolean|number[]
      -- position of the label extmark
      style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
      -- flash tries to re-use labels that were already assigned to a position,
      -- when typing more characters. By default only lower-case labels are re-used.
      reuse = "lowercase", ---@type "lowercase" | "all" | "none"
      -- for the current window, label targets closer to the cursor first
      distance = true,
      -- minimum pattern length to show labels
      -- Ignored for custom labelers.
      min_pattern_length = 1,
      -- Enable this to use rainbow colors to highlight labels
      -- Can be useful for visualizing Treesitter ranges.
      rainbow = {
        enabled = true,
        -- number between 1 and 9
        shade = 5,
      },
    },
    ---@type table<string, Flash.Config>
    modes = {
      -- a regular search with `/` or `?`
      search = {
        enabled = true,
        highlight = { backdrop = true },
        jump = { history = true, register = true, nohlsearch = true },
      },
      -- options used when flash is activated through
      -- `f`, `F`, `t`, `T`, `<` and `>` motions
      char = {
        enabled = true,
        -- hide after jump when not using jump labels
        autohide = false,
        -- show jump labels
        jump_labels = false,
        -- set to `false` to use the current line only
        multi_line = true,
        -- When using jump labels, don't use these keys
        -- This allows using those keys directly after the motion
        label = { exclude = "hjkliardc" },
        -- by default all keymaps are enabled, but you can disable some of them,
        -- by removing them from the list.
        -- If you rather use another key, you can map them
        -- to something else, e.g., { [";"] = "L", [","] = H }
        keys = { "f", "F", "t", "T", "[", "]" },
        ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
        -- The direction for `prev` and `next` is determined by the motion.
        -- `left` and `right` are always left and right.
        char_actions = function(motion)
          return {
            ["]"] = "next", -- set to `right` to always go right
            ["["] = "prev", -- set to `left` to always go left
            [motion:lower()] = "next",
            [motion:upper()] = "prev",
          }
        end,
        search = { wrap = false },
        highlight = { backdrop = true },
        jump = {
          register = false,
          -- when using jump labels, set to 'true' to automatically jump
          -- or execute a motion when there is only one match
          autojump = false,
        },
      },
      -- options used for treesitter selections
      -- `require("flash").treesitter()`
      treesitter = {
        labels = "abcdefghijkmnoprstuvwxy",
        jump = { pos = "range", autojump = true },
        search = { incremental = false },
        label = { before = true, after = true, style = "inline" },
        highlight = {
          backdrop = false,
          matches = false,
        },
      },
      treesitter_search = {
        jump = { pos = "range" },
        search = { multi_window = true, wrap = true, incremental = false },
        remote_op = { restore = true },
        label = { before = true, after = true, style = "inline" },
      },
      -- options used for remote flash
      remote = {
        remote_op = { restore = true, motion = true },
      },
    },
  },


  -- stylua: ignore
  keys = {
    {
      ",,w",
      mode = {"n"},
      function()
        require("flash").jump({
          pattern = vim.fn.expand("<cword>"),
        })
      end,
      desc = "Flash Word"
    },
    { ",,s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { ",,S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { ",,r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { ",,R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { ",,<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
