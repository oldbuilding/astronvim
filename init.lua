-- if vim.env.VSCODE then vim.g.vscode = true end

-- This "lua.keymaps"straps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath
    }
  )
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    {
      {
        ("Unable to load lazy from: %s\n"):format(lazypath),
        "ErrorMsg"
      },
      { "Press any key to exit...", "MoreMsg" }
    },
    true,
    {}
  )
  vim.fn.getchar()
  vim.cmd.quit()
end

require("utils")
require("config.options").setup()
require("config.environment").setup()
require("config.diagnostics").setup()
require("config.autocmd").setup()
-- require("config.keymaps").setup()
-- require("lsp").setup()
require("lazy_setup")

require("utils.astrocore")

-- Register keymaps after lazy.nvim has loaded which-key.nvim
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function() require("config.keymaps").setup() end,
})

-- don't do anything in vscode instances
-- if vim.g.vscode then
--   return {}
-- end
