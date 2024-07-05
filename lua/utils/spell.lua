local M = {}

function M.get_spell_directory_and_filename()
  local spell_directory = vim.fn.expand("~/.config/" .. (os.getenv("NVIM_APPNAME") or "astronvim") .. "/spell/")
  local spell_file = "en.utf-8.add"
  require("noice").notify("SPELLFILE -> " .. spell_directory .. spell_file, vim.log.levels.INFO)
  return spell_directory, spell_file
end

function M.rebuild_spell_binary()
  local spell_directory, spell_file = M.get_spell_directory_and_filename()
  local spell_file_path = spell_directory .. spell_file
  local cmd = 'mkspell! ' .. spell_file_path
  vim.fn.system('nvim --headless -c "' .. cmd .. '" -c "qall"')
  require("noice").notify("Rebuild Spell file binary", vim.log.levels.INFO)
end

return M
