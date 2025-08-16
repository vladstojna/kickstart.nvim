local function set_diagnostic_signs()
  local signs = {
    Error = ' ',
    Warn = ' ',
    Hint = ' ',
    Info = ' ',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

set_diagnostic_signs()
require('custom.format').create_autoformat_toggle_command()
