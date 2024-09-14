local M = {}

M.get_brew_bin = function()
  local brew_bin = os.getenv("brewbin") or "/home/linuxbrew/.linuxbrew/bin/"
  if brew_bin == nil or brew_bin == "" then brew_bin = "/home/linuxbrew/.linuxbrew/opt" end
  require("utils.logging").notify("BREW BIN -> " .. brew_bin, vim.log.levels.INFO)
  return brew_bin
end

M.get_brew_opt = function()
  local brew_opt = os.getenv("brewopt") or "/home/linuxbrew/.linuxbrew/opt"
  if brew_opt == nil or brew_opt == "" then brew_opt = "/home/linuxbrew/.linuxbrew/opt" end
  require("utils.logging").notify("BREW OPT -> " .. brew_opt, vim.log.levels.INFO)
  return brew_opt
end

M.get_hererocks_path = function()
  local hererocks_path = os.getenv("HOME") .. "/.local/pipx/venvs/hererocks"
  require("utils.logging").notify("HEREROCKS -> " .. hererocks_path, vim.log.levels.INFO)
  return hererocks_path
end

M.get_python3_host_prog = function()
  local python3_host_prog = os.getenv("brewpythonpath")
  require("utils.logging").notify("PYTHON3 -> " .. python3_host_prog, vim.log.levels.INFO)
  return python3_host_prog
end

M.setup = function()
  local brew_opt_path = M.get_brew_opt()
  local brew_bin_path = M.get_brew_bin()

  vim.env.BREW_OPT_PATH = brew_opt_path
  vim.env.BREW_BIN_PATH = brew_bin_path

  local hererocks_path = M.get_hererocks_path()

  vim.env.HEREROCKS_PATH = hererocks_path

  package.path = package.path .. ";" .. hererocks_path .. "/share/lua/5.1/?.lua;" .. hererocks_path .. "/share/lua/5.1/?/init.lua;"

  package.cpath = package.cpath .. ";" .. hererocks_path .. "/lib/lua/5.1/?.so;"

  vim.env.GIT_EXEC_PATH = brew_opt_path .. "/git/libexec/git-core"

  vim.env.LUA_PATH = hererocks_path .. "/share/lua/5.1/?.lua;" .. hererocks_path .. "/share/lua/5.1/?/init.lua;;"
  vim.env.LUA_CPATH = hererocks_path .. "/lib/lua/5.1/?.so;;"

  vim.env.PATH = hererocks_path .. "/bin:" .. vim.env.PATH
end

return M
