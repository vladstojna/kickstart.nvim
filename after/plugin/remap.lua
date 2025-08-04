vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '//', 'y/\\V<C-R>"<CR>N')

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-s>', '<C-u>zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', [["_dP]])

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set('n', '<leader>ru', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace word [U]nder cursor' })
vim.keymap.set('x', '<leader>r', [["hy:%s/<C-r>h/<C-r>h/gI<Left><Left><Left>]], { desc = '[R]eplace selection' })

vim.keymap.set('n', '<leader>w', vim.cmd.w, { silent = true, noremap = true, desc = 'Save buffer' })
vim.keymap.set('n', '<leader>q', vim.cmd.q, { silent = true, noremap = true, desc = 'Quit' })
vim.keymap.set('n', '<leader>qq', vim.cmd.qa, { silent = true, noremap = true, desc = 'Quit all' })

vim.keymap.set('n', '<C-k>', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<C-j>', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader><Tab>', ':b#<cr>', { silent = true, noremap = true, desc = 'Toggle between last two buffers' })
vim.keymap.set('n', '<leader>ct', ':tabclose<cr>', { silent = true, noremap = true, desc = '[C]lose [T]ab' })
vim.keymap.set('n', '<C-Left>', 'gT', { silent = true, noremap = true, desc = 'Previous Tab' })
vim.keymap.set('n', '<C-Right>', 'gt', { silent = true, noremap = true, desc = 'Next Tab' })
