return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      popup_border_style = "rounded",
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          indent_marker = "┊",
          last_indent_marker = "╰",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "⛆ ", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "⅏ ", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✂ ", -- this can only be used in the git_status source
            renamed = "↹", -- ⅏  this can only be used in the git_status source
            -- Status type
            untracked = "␦",
            ignored = "⍉ ",
            unstaged = "▒",
            staged = "▓",
            conflict = "⏚",
          },
        },
      },
      window = {
        width = 42, -- Set your default width here
      },
    })

    local function get_max_line_length()
      local max_length = 0
      local lines = vim.fn.getbufline(require("neo-tree").tree.bufnr(), 1, "$")
      for _, line in ipairs(lines) do
        local length = vim.fn.strdisplaywidth(line)
        if length > max_length then max_length = length end
      end
      return max_length
    end

    local function adjust_width()
      local max_length = get_max_line_length()
      vim.cmd("vertical resize " .. (max_length + 2)) -- Add padding to the width if necessary
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "NeoTree*",
      callback = function() adjust_width() end,
    })
  end,
}
