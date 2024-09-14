local M = {}

M.contains = function(list, item)
  if not list then return false end
  for _, value in ipairs(list) do
    if value == item then return true end
  end
  return false
end

M.insert_unique = function(list, value)
  -- Ensure list is a table
  if not list then list = {} end

  -- Check if the value already exists in the list
  for _, v in ipairs(list) do
    if v == value then
      return false -- Value already exists, do nothing
    end
  end

  -- If the value is not found, insert it
  table.insert(list, value)
  return true -- Value was inserted
end

return M
