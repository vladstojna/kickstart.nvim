local M = {
  lldb = {
    name = 'lldb',
    type = 'executable',
    command = 'lldb-dap',
  },

  gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap', '--eval-command', 'set print pretty on' },
  },

  cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath 'data' .. '/mason/bin/OpenDebugAD7',
    options = {
      -- Do not run detached on windows
      detached = vim.fn.has 'win32' == 0,
    },
  },

  codelldb = {
    type = 'executable',
    command = 'codelldb',

    -- Do not run detached on windows
    detached = vim.fn.has 'win32' == 0,
  },
}
return M
