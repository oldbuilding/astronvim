-- lua/lsp/lines.lua
return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  ft = "rust",
  lazy = false,
  after = "mason-lspconfig.nvim",
  module = "lsp_lines",
  enabled = true,
  start = true,
  event = "LspAttach",
  opts = {
    keys = {
      vim.keymap.set("n", "<leader>l", ":lua require('lsp_lines').toggle()<CR>", { desc = "Toggle lsp_lines", noremap = true, silent = true }), -- Toggle lsp lines
    },
    vim.diagnostic.config({
      virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
      virtual_lines = { only_current_line = false },
    }),
  },
  -- config = function(_, opts)
  --   -- local wk = require("which-key")
  --   require("lsp_lines").setup()
  -- end
}
