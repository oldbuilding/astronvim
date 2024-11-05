---@type LazySpec
return {
  "folke/noice.nvim",
  event = "VeryLazy", -- Change this to ensure it's loaded at the right time
  dependencies = {
    -- Required dependencies
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- Noice relies on nvim-notify, but we will configure it not to display popups
  },
  opts = function()
    require("noice").setup({
      views = {
        -- Mini view used for compact display in the lower right
        mini = {
          backend = "mini",
          align = "right",
          relative = "editor",
          position = {
            row = -2, -- Position 2 rows from the bottom
            col = "100%",
          },
          size = "auto",
          win_options = {
            winblend = 100, -- Make the mini window fully transparent in the background
          },
        },
        -- Custom virtual text view for displaying the last 10 messages
        virtualtext = {
          backend = "virtualtext",
          format = "{message}",
          align = "right",
          relative = "editor",
          position = {
            row = -2, -- Position 2 rows from the bottom
            col = "100%",
          },
          size = {
            height = 10,
          },
          win_options = {
            winblend = 50,
          },
        },
        -- Existing configurations for other popups or displays
        cmdline_popup = {
          position = {
            row = 19,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "DiagnosticInfo",
            },
          },
        },
      },
      routes = {
        {
          view = "cmdline_popup",
          filter = { event = "msg_showmode" },
        },
        -- Route notifications that would have shown in vim.notify to noice mini
        {
          filter = { event = "notify" },
          view = "mini",
        },
      },
      lsp = {
        -- LSP-related configurations remain the same
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = true,
          view = "mini",
        },
        progress = {
          enabled = true,
          view = "mini",
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
          view = "hover",
        },
        message = {
          enabled = true,
          view = "mini",
        },
        documentation = {
          enabled = true,
          view = "hover",
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
        },
      },
      messages = {
        enabled = true,
        view = "virtualtext", -- Use virtual text to show recent messages
        view_error = "mini",
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      },
      notify = {
        enabled = true,
        view = "mini", -- Redirect all notify messages to the mini view
      },
      presets = {
        bottom_search = false, -- Disable default bottom search to reduce clutter
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline_popup",
      },
    })
  end,
  config = function(_, opts)
    require("noice").setup(opts) -- Corrected the setup call to ensure options are passed properly
  end,
}
