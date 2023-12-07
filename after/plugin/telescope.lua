local telescope_builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local telescope = require 'telescope'

telescope.setup {
    pickers = {
        buffers = {
            sort_last_used = true,
            previewer = false,
            theme = 'dropdown',
            layout_config = { width = 0.4 },
            mappings = {
                i = {
                    ['<c-d>'] = actions.delete_buffer,
                },
                n = {
                    ['dd'] = actions.delete_buffer,
                },
            },
        },
    },
}

vim.keymap.set('n', '<leader>sa', function()
    telescope_builtin.find_files {
        hidden = true,
        no_ignore = false,
    }
end, { desc = '[S]earch [A]ll Files (+ hidden)' })

vim.keymap.set('n', '<leader>sA', function()
    telescope_builtin.find_files {
        hidden = true,
        no_ignore = true,
    }
end, { desc = '[S]earch [A]ll Files (+ hidden & ignored)' })

vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader><Tab>', telescope_builtin.buffers, { desc = '[Tab] Find existing buffers' })
