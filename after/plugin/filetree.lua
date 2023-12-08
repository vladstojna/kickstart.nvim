vim.keymap.set('n', '<leader>-', '<cmd>Oil<cr>',
    { noremap = true, desc = 'Explore parent directory of current buffer', silent = true })
vim.keymap.set('n', '<leader>E', '<cmd>Oil .<cr>', { noremap = true, desc = '[E]xplore root directory', silent = true })
