local dap = require 'dap'

local function insert_configs(tab, debugger_name)
  -- General configurations,
  -- adapted from: https://blog.cryptomilk.org/2024/01/02/neovim-dap-and-gdb-14-1/
  table.insert(tab, {
    name = 'Run executable (' .. debugger_name .. ')',
    type = debugger_name,
    request = 'launch',
    -- This requires special handling of 'run_last', see
    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
    program = function()
      local path = vim.fn.input {
        prompt = 'Path to executable: ',
        default = vim.fn.getcwd() .. '/',
        completion = 'file',
      }

      return (path and path ~= '') and path or dap.ABORT
    end,
  })
  table.insert(tab, {
    name = 'Run executable with arguments (' .. debugger_name .. ')',
    type = debugger_name,
    request = 'launch',
    -- This requires special handling of 'run_last', see
    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
    program = function()
      local path = vim.fn.input {
        prompt = 'Path to executable: ',
        default = vim.fn.getcwd() .. '/',
        completion = 'file',
      }

      return (path and path ~= '') and path or dap.ABORT
    end,
    args = function()
      local args_str = vim.fn.input {
        prompt = 'Arguments: ',
      }
      return vim.split(args_str, ' +')
    end,
  })
  table.insert(tab, {
    name = 'Attach to process (' .. debugger_name .. ')',
    type = debugger_name,
    request = 'attach',
    processId = require('dap.utils').pick_process,
  })
end

local function gdbserver_attach(tab, adapter_name, libs_type)
  table.insert(tab, {
    name = 'Attach to gdbserver (' .. libs_type .. ')',
    type = adapter_name,
    request = 'attach',
    target = function()
      return vim.fn.input { prompt = 'Target: ', default = ':2345' }
    end,
    cwd = '${workspaceFolder}',
  })
end

local M = {}
insert_configs(M, 'gdb')
insert_configs(M, 'lldb')
gdbserver_attach(M, 'gdb_localsysroot', 'local libs')
gdbserver_attach(M, 'gdb', 'remote libs')
return M
