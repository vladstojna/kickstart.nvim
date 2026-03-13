-- Run last: https://github.com/mfussenegger/nvim-dap/issues/1025
local last_config = nil

local M = {}

---@param session dap.Session
M.save_config = function(session) last_config = session.config end

--- Re-run last session after expanding and enriching
M.run_last = function()
  local dap = require 'dap'
  if last_config then
    dap.run(last_config)
  else
    dap.continue()
  end
end

M.get_config = function() return last_config end

M.set_config = function(cfg) last_config = cfg end

return M
