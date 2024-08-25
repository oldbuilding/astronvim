local M = {}

function M.get_brew_bin()
  local Path = require("plenary.path")
  local brew_bin = os.getenv("brewbin") or "/home/linuxbrew/.linuxbrew/bin/"
  require("noice").notify("BREW BIN -> " .. brew_bin, vim.log.levels.INFO)
  return brew_bin
end

function M.get_brew_opt()
  local Path = require("plenary.path")
  local brew_opt = os.getenv("brewopt") or "/home/linuxbrew/.linuxbrew/opt"
  require"noice".notify("BREW OPT -> " .. brew_opt, vim.log.levels.INFO)
  return brew_opt
end

function M.get_hererocks_path()
  local Path = require("plenary.path")
  local hererocks_path = os.getenv("HOME") .. "/.local/pipx/venvs/hererocks"
  require"noice".notify("HEREROCKS -> " .. hererocks_path, vim.log.levels.INFO)
  return hererocks_path
end

function M.find_project_root()
  local Path = require("plenary.path")
  -- Function finds the nearest project root by locating the .git directory
  local cwd = vim.fn.getcwd()
  local current_path = Path:new(cwd)

  while not current_path:joinpath(".git"):exists() do
    if current_path == current_path:parent() then
      return nil
    end
    current_path = current_path:parent()
  end

  local result = current_path:absolute()
  require("noice").notify("PROJECT ROOT -> " .. result , vim.log.levels.INFO)
  return result
end

function M.get_editorconfig_path()
  local Path = require("plenary.path")
  local project_root = M.find_project_root()
  if project_root then
    local project_config = Path:new(project_root, ".editorconfig")
    if project_config:exists() then
      require("noice").notify(".EDITORCONFIG -> found", vim.log.levels.INFO)
      return project_config:absolute()
    end
    require("noice").notify(".EDITORCONFIG -> NOT found", vim.log.levels.WARN)
  end
  return vim.fn.expand("~/.editorconfig")
end

function M.get_mason_bin()
  return vim.fn.expand("~/.local/share/astronvim/mason/bin")
end

return M
