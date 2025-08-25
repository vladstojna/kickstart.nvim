local dap = require 'dap'

local function executable_input()
  local path = vim.fn.input {
    prompt = 'Path to executable: ',
    default = vim.fn.getcwd() .. '/',
    completion = 'file',
  }

  return (path and path ~= '') and path or dap.ABORT
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

local launch = function(adapter)
  return {
    name = 'Run executable (' .. adapter .. ')',
    type = adapter,
    request = 'launch',
    -- This requires special handling of 'run_last', see
    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
    program = executable_input,
    cwd = '${workspaceFolder}',
  }
end

local launch_with_args = function(adapter)
  return {
    name = 'Run executable with arguments (' .. adapter .. ')',
    type = adapter,
    request = 'launch',
    -- This requires special handling of 'run_last', see
    -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
    program = executable_input,
    cwd = '${workspaceFolder}',
    args = function()
      local args_str = vim.fn.input {
        prompt = 'Arguments: ',
      }
      return vim.split(args_str, ' +')
    end,
  }
end

local attach = function(adapter)
  return {
    name = 'Attach to process (' .. adapter .. ')',
    type = adapter,
    request = 'attach',
    processId = require('dap.utils').pick_process,
    cwd = '${workspaceFolder}',
  }
end

local M = {}

for _, what in ipairs { launch, launch_with_args, attach } do
  table.insert(
    M,
    vim.tbl_extend('error', {
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailures = false,
        },
      },
    }, what 'cppdbg')
  )
  table.insert(M, what 'codelldb')
  table.insert(M, what 'gdb')
  table.insert(M, what 'lldb')
end

gdbserver_attach(M, 'gdb_localsysroot', 'local libs')
gdbserver_attach(M, 'gdb', 'remote libs')

return M
