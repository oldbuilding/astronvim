---@type LazySpec
return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim"
    },
    config = { lsp = { signature = { enabled = false } } },
    opts = function(plugin, opts)
        require("noice").setup {
            views = {
                cmdline_popup = {
                    position = {
                        row = 9,
                        col = "50%"
                    },
                    size = {
                        width = 60,
                        height = "auto"
                    }
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%"
                    },
                    size = {
                        width = 60,
                        height = 10
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 }
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }
                    }
                }
            },
            routes = {
                {
                    view = "cmdline",
                    filter = { event = "msg_showmode" }
                }
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                },
                hover = {
                    enabled = true,
                    silent = true,
                    view = "mini"
                },
                progress = {
                    enabled = false
                },
                signature = {
                    -- config.lsp.signature.enabled
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        luasnip = true,
                        throttle = 50
                    },
                    view = "mini"
                },
                -- Messages shown by lsp server
                message = {
                    enabled = true,
                    view = "mini"
                },
                documentation = {
                    enabled = true,
                    view = "hover",
                    ---@type NoiceViewOptions
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 }
                        }
                    }
                }
            },
            messages = {
                enabled = true,
                view = "mini",
                view_error = "mini",
                view_warn = "mini",
                view_history = "messages",
                view_search = "virtualtext"
            },
            notify = {
                enabled = true,
                view = "mini"
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = false,      -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true         -- add a border to hover docs and signature help
            },
            cmdline = {
                view = "cmdline"
            }
        }
    end
}
