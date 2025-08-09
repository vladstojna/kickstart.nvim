vim.api.nvim_create_autocmd('SessionLoadPost', {
  desc = 'Load breakpoints after session is loaded',
  callback = function()
    -- avoid loading all dap plugins if no breakpoints exist for session
    if vim.g.Breakpoints ~= nil then
      require('custom.dap.persistent_breakpoints').load_breakpoints()
    end
  end,
})
