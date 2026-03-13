vim.api.nvim_create_autocmd('SessionLoadPost', {
  desc = 'Load breakpoints after session is loaded',
  callback = function()
    -- avoid loading all dap plugins if no breakpoints exist for session
    if vim.g.Breakpoints ~= nil then require('custom.dap.persistent_breakpoints').load_breakpoints() end
  end,
})

vim.api.nvim_create_autocmd('SessionLoadPost', {
  desc = 'Load saved DAP session config after session is loaded',
  callback = function()
    if vim.g.DapSessionConfig ~= nil then require('custom.dap.run_last').set_config(vim.json.decode(vim.g.DapSessionConfig)) end
  end,
})

local cmdGrp = vim.api.nvim_create_augroup('cmdline_height', { clear = true })
local function set_cmdheight(val)
  if vim.opt.cmdheight:get() ~= val then
    vim.opt.cmdheight = val
    vim.cmd.redrawstatus()
  end
end

vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = cmdGrp,
  callback = function() set_cmdheight(1) end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = cmdGrp,
  callback = function() set_cmdheight(0) end,
})

vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = vim.api.nvim_create_augroup('UpdateLocListOnDiagnostics', { clear = true }),
  callback = function(_)
    vim.diagnostic.setloclist {
      open = false,
    }
  end,
})
