local M = {
  lldb = {
    name = 'lldb',
    type = 'executable',
    command = 'lldb-dap',
  },

  gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' },
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

  gdbserver = function(on_config, _)
    local adapter_tbl = {
      type = 'executable',
      command = 'gdb',
      args = { '--quiet', '--interpreter=dap' },
      enrich_config = function(initial_config, on_config_enrich)
        vim.ui.input({ prompt = 'Target: ', default = ':2345' }, function(input)
          local final_config = vim.deepcopy(initial_config)
          final_config.target = input
          on_config_enrich(final_config)
        end)
      end,
    }

    vim.ui.input({ prompt = 'Sysroot: ', default = '/' }, function(input)
      input = input == nil and '' or string.gsub(input, '%s+', '')
      if input ~= '' then
        table.insert(adapter_tbl.args, '--eval-command')
        table.insert(adapter_tbl.args, 'set sysroot ' .. input)
      end
      on_config(adapter_tbl)
    end)
  end,
}
return M
