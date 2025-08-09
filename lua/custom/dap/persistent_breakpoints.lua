-- Adapted from: https://github.com/mfussenegger/nvim-dap/issues/198#issuecomment-2764679167

local M = {}
local dap = require 'dap'
local breakpoints = require 'dap.breakpoints'

--- Store all breakpoints in a global variable to be persisted in the session
--- INFO: Have to add globals to vim.opt.sessionoptions
M._store_breakpoints = function()
  local bps = {}
  for buffer_id, buffer_breakpoints in pairs(breakpoints.get()) do
    local filename = vim.api.nvim_buf_get_name(buffer_id)
    bps[filename] = buffer_breakpoints
  end

  -- If no breakpoints, we want to unset the global variable to avoid
  -- persisting the variable
  if next(bps) == nil then
    M._clear_breakpoints()
  else
    vim.g.Breakpoints = vim.json.encode(bps)
  end
end

--- Load existing breakpoints for all open buffers in the session
M.load_breakpoints = function()
  local bps = vim.json.decode(vim.g.Breakpoints)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local filename = vim.api.nvim_buf_get_name(buf)
    local buffer_breakpoints = bps[filename]
    if buffer_breakpoints ~= nil then
      for _, bp in pairs(buffer_breakpoints) do
        local line = bp.line
        local opts = {
          condition = bp.condition,
          log_message = bp.logMessage,
          hit_condition = bp.hitCondition,
        }
        breakpoints.set(opts, buf, line)
      end
    end
  end
end

M._clear_breakpoints = function()
  vim.g.Breakpoints = nil
end

--- Toggle a breakpoint and ensure it is persisted in the session
M.toggle_breakpoint = function()
  dap.toggle_breakpoint()
  M._store_breakpoints()
end

--- Create a conditional breakpoint and ensure it is persisted in the session
M.set_breakpoint = function(condition)
  dap.set_breakpoint(condition)
  M._store_breakpoints()
end

--- Create a log point and ensure it is persisted in the session
M.set_log_point = function(message)
  dap.set_breakpoint(nil, nil, message)
  M._store_breakpoints()
end

--- Clear all breakpoints and ensure they are persisted in the session
M.clear_breakpoints = function()
  dap.clear_breakpoints()
  M._clear_breakpoints()
end

return M
