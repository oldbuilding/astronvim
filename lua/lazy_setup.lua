local M = {}

M.contains = function(list, item)
  if not list then return false end
  for _, value in ipairs(list) do
    if value == item then return true end
  end
  return false
end

M.insert_unique = function(list, values)
  -- Ensure list is a table
  if not list then list = {} end

  -- Ensure values is a table
  if type(values) ~= "table" then
    values = { values }
  end

  local inserted_any = false

  -- Iterate over the values to insert
  for _, value in ipairs(values) do
    -- Check if the value already exists in the list
    local exists = false
    for _, v in ipairs(list) do
      if v == value then
        exists = true
        break
      end
    end

    -- If the value is not found, insert it
    if not exists then
      table.insert(list, value)
      inserted_any = true
    end
  end

  if inserted_any then
    return list
  else
    return {}
  end
end

M.insert_unique_single = function(list, value)
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
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
    k,
  },
} --[[@as LazyConfig]])
