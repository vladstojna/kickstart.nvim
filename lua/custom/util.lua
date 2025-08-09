local M = {}

M.copy_active_buffer_path = function(register)
  vim.fn.setreg(register ~= nil and register or '', vim.fn.getreg '%')
  vim.notify('Copied ' .. vim.fn.getreg '%', vim.log.levels.INFO)
end

M.copy_active_buffer_abs_path = function(register)
  local abs_path = vim.fn.getcwd() .. '/' .. vim.fn.getreg '%'
  vim.fn.setreg(register ~= nil and register or '', abs_path)
  vim.notify('Copied ' .. abs_path, vim.log.levels.INFO)
end

return M
