local M = {}

local Path = require("plenary.path")

function M.get_brew_bin()
  return os.getenv("brewbin") or "/home/linuxbrew/.linuxbrew/bin/"
end

function M.find_project_root()
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
