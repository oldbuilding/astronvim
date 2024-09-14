local M = {}

local message_queue = {}

-- Utility function to handle notifications
M.notify = function(msg, level)
  -- Try to use Noice if available
  local ok, noice = pcall(require, "noice")
  if ok then
    -- Noice is available, send the message immediately
    noice.notify(msg, level)

    -- Flush any queued messages
    for _, queued_msg in ipairs(message_queue) do
      noice.notify(queued_msg.msg, queued_msg.level)
    end
    -- Clear the queue after flushing
    message_queue = {}
  else
    -- Noice isn't available, queue the message
    table.insert(message_queue, { msg = msg, level = level })

    -- Fallback to vim.notify immediately
    vim.notify(msg, level)
  end
end

-- Optionally, add a function to manually flush the queue when you know Noice is ready
M.flush_queue = function()
  local ok, noice = pcall(require, "noice")
  if ok then
    for _, queued_msg in ipairs(message_queue) do
      noice.notify(queued_msg.msg, queued_msg.level)
    end
    -- Clear the queue after flushing
    message_queue = {}
  end
end

return M
