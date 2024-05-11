local M = {
  lua = { 'stylua' },
  python = { 'isort', 'black' },
  tex = { 'latexindent' },
}

for _, lang in ipairs { 'sh', 'bash', 'zsh' } do
  M[lang] = { 'shfmt' }
end
for _, lang in ipairs { 'typescript', 'javascript', 'json', 'markdown', 'yaml' } do
  M[lang] = { { 'prettierd', 'prettier' } }
end

return M
