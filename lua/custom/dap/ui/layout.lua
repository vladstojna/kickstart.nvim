local has_override, override = pcall(require, 'custom.dap.ui.host-override')

if has_override and type(override) == 'table' then
  return override
else
  local M = {
    layouts = {
      {
        elements = {
          {
            id = 'stacks',
            size = 0.75,
          },
          {
            id = 'console',
            size = 0.25,
          },
        },
        position = 'left',
        size = 0.25,
      },
      {
        elements = {
          {
            id = 'breakpoints',
            size = 0.375,
          },
          {
            id = 'watches',
            size = 0.375,
          },
          {
            id = 'repl',
            size = 0.25,
          },
        },
        position = 'right',
        size = 0.25,
      },
      {
        elements = {
          {
            id = 'scopes',
            size = 1,
          },
        },
        position = 'bottom',
        size = 0.33,
      },
    },
  }
  return M
end
