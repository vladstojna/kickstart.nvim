local M = {}

M.set_keymaps = function()
  vim.keymap.set('n', '[f', require('dap').up, { desc = 'Debug: go to previous frame' })
  vim.keymap.set('n', '[4', require('dap').up, { desc = 'Debug: go to previous frame' })

  vim.keymap.set('n', ']f', require('dap').down, { desc = 'Debug: go to next frame' })
  vim.keymap.set('n', ']4', require('dap').down, { desc = 'Debug: go to next frame' })
end

M.unset_keymaps = function()
  for _, v in ipairs { '[f', '[4', ']f', ']4' } do
    vim.keymap.del('n', v)
  end
end

return M
