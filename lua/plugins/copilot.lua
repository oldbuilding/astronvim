return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    enable = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<M-CR>",
          accept_word = "<M-w>",
          accept_line = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-c>",
        },
      },
      filetypes = { ["*"] = true },
      -- copilot_node_command = "node", -- Node.js version must be > 18.x
      -- server_opts_overrides = {},
      keys = {
        {
          "<M-c><M-p>",
          function() require("copilot.suggestion").prev() end,
          desc = "Copilot Suggest Previous",
        },
        {
          "<M-c><M-n>",
          function() require("copilot.suggestion").next() end,
          desc = "Copilot Suggest Next",
        },
        {
          "<M-c>",
          function() require("copilot").open() end,
          "+Copilot",
        },
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      vim.cmd([[
        autocmd BufEnter * :Copilot enable
      ]])
    end,
  },
}
