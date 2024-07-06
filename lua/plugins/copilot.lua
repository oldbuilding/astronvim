if true then return {} end
return {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<Tab>",
          refresh = "gr",
          open = "<M-p>",
        },
        layout = {
          position = "top", -- | top | left | right
          ratio = 0.4,
        },
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
      copilot_node_command = "node", -- Node.js version must be > 18.x
      server_opts_overrides = {},
    },
    keys = {
      {
        "cco",
        function() require("copilot").open() end,
        desc = "Open Copilot",
      },
      {
        "ccs",
        function() require("copilot").suggest() end,
        desc = "Suggest Copilot",
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      -- Add which-key mappings
      local wk = require("which-key")
      wk.register({
        c = {
          c = {
            name = "+Copilot",
            o = "Open Copilot",
            s = "Copilot Suggestions",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function() require("copilot_cmp").setup() end,
  },
}
-- {
--     "CopilotC-Nvim/CopilotChat.nvim",
--     dependencies = {
--         { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
--         { "nvim-lua/plenary.nvim" },
--     },
--     opts = {
--         show_help = false,
--         mappings = {
--             -- Use tab for completion
--             complete = {
--                 detail = "Use @<Tab> or /<Tab> for options.",
--                 insert = "<Tab>",
--             },
--             -- Close the chat
--             close = {
--                 normal = "q",
--                 insert = "<C-c>",
--             },
--             -- Reset the chat buffer
--             reset = {
--                 normal = "<C-x>",
--                 insert = "<C-x>",
--             },
--             -- Submit the prompt to Copilot
--             submit_prompt = {
--                 normal = "<CR>",
--                 insert = "<C-CR>",
--             },
--             -- Accept the diff
--             accept_diff = {
--                 normal = "<C-y>",
--                 insert = "<C-y>",
--             },
--             -- Yank the diff in the response to register
--             yank_diff = {
--                 normal = "gmy",
--             },
--             -- Show the diff
--             show_diff = {
--                 normal = "gmd",
--             },
--             -- Show the prompt
--             show_system_prompt = {
--                 normal = "gmp",
--             },
--             -- Show the user selection
--             show_user_selection = {
--                 normal = "gms",
--             },
--         },
--     },
--     config = function(_, opts)
--         local chat = require("CopilotChat")
--         local select = require("CopilotChat.select")
--         -- Use unnamed register for the selection
--         opts.selection = select.unnamed

--         -- Override the git prompts message
--         opts.prompts.Commit = {
--             prompt = "Write commit message for the change with commitizen convention",
--             selection = select.gitdiff,
--         }
--         opts.prompts.CommitStaged = {
--             prompt = "Write commit message for the change with commitizen convention",
--             selection = function(source)
--                 return select.gitdiff(source, true)
--             end,
--         }

--         chat.setup(opts)
--         -- Setup the CMP integration
--         require("CopilotChat.integrations.cmp").setup()

--         vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
--             chat.ask(args.args, { selection = select.visual })
--         end, { nargs = "*", range = true })

--         -- Inline chat with Copilot
--         vim.api.nvim_create_user_command("CopilotChatInline", function(args)
--             chat.ask(args.args, {
--                 selection = select.visual,
--                 window = {
--                     layout = "float",
--                     relative = "cursor",
--                     width = 1,
--                     height = 0.4,
--                     row = 1,
--                 },
--             })
--         end, { nargs = "*", range = true })

--         -- Restore CopilotChatBuffer
--         vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
--             chat.ask(args.args, { selection = select.buffer })
--         end, { nargs = "*", range = true })

--         -- Custom buffer for CopilotChat
--         vim.api.nvim_create_autocmd("BufEnter", {
--             pattern = "copilot-*",
--             callback = function()
--                 vim.opt_local.relativenumber = true
--                 vim.opt_local.number = true

--                 -- Get current filetype and set it to markdown if the current filetype is copilot-chat
--                 local ft = vim.bo.filetype
--                 if ft == "copilot-chat" then
--                     vim.bo.filetype = "markdown"
--                 end
--             end,
--         })

--         -- Add which-key mappings
--         local wk = require("which-key")
--         wk.register({
--             g = {
--                 m = {
--                     name = "+Copilot Chat",
--                     d = "Show diff",
--                     p = "System prompt",
--                     s = "Show selection",
--                     y = "Yank diff",
--                 },
--             },
--         })
--     end,
--     event = "VeryLazy",
--     keys = {
--         -- Show help actions with telescope
--         {
--             "<leader>ah",
--             function()
--                 local actions = require("CopilotChat.actions")
--                 require("CopilotChat.integrations.telescope").pick(actions.help_actions())
--             end,
--             desc = "CopilotChat - Help actions",
--         },
--         -- Show prompts actions with telescope
--         {
--             "<leader>ap",
--             function()
--                 local actions = require("CopilotChat.actions")
--                 require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
--             end,
--             desc = "CopilotChat - Prompt actions",
--         },
--         {
--             "<leader>ap",
--             ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
--             mode = "x",
--             desc = "CopilotChat - Prompt actions",
--         },
--         -- Code related commands
--         { "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
--         { "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
--         { "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
--         { "<leader>aR", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
--         { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
--         -- Chat with Copilot in visual mode
--         {
--             "<leader>av",
--             ":CopilotChatVisual",
--             mode = "x",
--             desc = "CopilotChat - Open in vertical split",
--         },
--         {
--             "<leader>ax",
--             ":CopilotChatInline<cr>",
--             mode = "x",
--             desc = "CopilotChat - Inline chat",
--         },
--         -- Custom input for CopilotChat
--         {
--             "<leader>ai",
--             function()
--                 local input = vim.fn.input("Ask Copilot: ")
--                 if input ~= "" then
--                     vim.cmd("CopilotChat " .. input)
--                 end
--             end,
--             desc = "CopilotChat - Ask input",
--         },
--         -- Generate commit message based on the git diff
--         {
--             "<leader>am",
--             "<cmd>CopilotChatCommit<cr>",
--             desc = "CopilotChat - Generate commit message for all changes",
--         },
--         {
--             "<leader>aM",
--             "<cmd>CopilotChatCommitStaged<cr>",
--             desc = "CopilotChat - Generate commit message for staged changes",
--         },
--         -- Quick chat with Copilot
--         {
--             "<leader>aq",
--             function()
--                 local input = vim.fn.input("Quick Chat: ")
--                 if input ~= "" then
--                     vim.cmd("CopilotChatBuffer " .. input)
--                 end
--             end,
--             desc = "CopilotChat - Quick chat",
--         },
--         -- Debug
--         { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
--         -- Fix the issue with diagnostic
--         { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
--         -- Clear buffer and chat history
--         { "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
--         -- Toggle Copilot Chat Vsplit
--         { "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
--     },
-- },
