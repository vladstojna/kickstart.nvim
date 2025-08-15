-- bufdelete
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<CR>')
vim.keymap.set('n', '<leader>bD', '<cmd>Bdelete!<CR>')

-- oil
vim.keymap.set('n', '<leader>e', '<cmd>Oil --float<cr>', { noremap = true, desc = '[E]xplore directory of active buffer', silent = true })
vim.keymap.set('n', '<leader>E', '<cmd>Oil . --float<cr>', { noremap = true, desc = '[E]xplore root directory', silent = true })

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

-- todo-comments
vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble toggle<cr>', { desc = 'Todo (Trouble)' })

-- mini
require('mini.trailspace').setup()
require('mini.pairs').setup()

-- refactoring
local refactoring = require 'refactoring'
local telescope = require 'telescope'
telescope.load_extension 'refactoring'

vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
  telescope.extensions.refactoring.refactors()
end, { desc = '[R]efactoring Seach [R]efactor' })
vim.keymap.set({ 'x', 'n' }, '<leader>rv', function()
  refactoring.debug.print_var()
end, { desc = '[R]efactoring Print [V]ar' })
vim.keymap.set('n', '<leader>rc', function()
  refactoring.debug.cleanup {}
end, { desc = '[R]efactoring [C]leanup' })

-- no-neck-pain
vim.keymap.set('n', '<leader>cc', vim.cmd.NoNeckPain, { desc = 'Toggle Centered View' })

require('custom.format').create_autoformat_toggle_command()
