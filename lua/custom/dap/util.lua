--- Run function if DAP session is active
---@param on_active function
local function run_if_session_active(on_active)
  if require('dap').session() then
    on_active()
  else
    vim.notify('No DAP session active', vim.log.levels.WARN)
  end
end

--- Keymap wrapper
---@param key string
---@param func function
---@param desc string
local function map(key, func, desc)
  vim.keymap.set('n', key, func, { desc = desc })
end

local prev_frame = {
  desc = 'Debug: go to previous frame',
  func = function()
    run_if_session_active(require('dap').up)
  end,
}

local next_frame = {
  desc = 'Debug: go to next frame',
  func = function()
    run_if_session_active(require('dap').down)
  end,
}

local M = {}

M.set_keymaps = function()
  map('[f', prev_frame.func, prev_frame.desc)
  map('[4', prev_frame.func, prev_frame.desc)
  map(']f', next_frame.func, next_frame.desc)
  map(']4', next_frame.func, next_frame.desc)
end

return M
