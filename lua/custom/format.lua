local M = {}

M.formatters = {
  lua = { 'stylua' },
  python = { 'isort', 'black' },
  tex = { 'latexindent' },
}

for _, lang in ipairs { 'sh', 'bash', 'zsh' } do
  M.formatters[lang] = { 'shfmt' }
end
for _, lang in ipairs { 'typescript', 'javascript', 'json', 'markdown', 'yaml' } do
  M.formatters[lang] = { 'prettierd', 'prettier' }
end

M.autoformat_enabled = true

M.create_autoformat_toggle_command = function()
  vim.api.nvim_create_user_command('FormatOnSaveToggle', function(_)
    M.autoformat_enabled = not M.autoformat_enabled
    vim.notify('Format on save: ' .. (M.autoformat_enabled and 'enabled' or 'disabled'))
  end, {})
end

return M
