-- bufdelete
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<CR>')
vim.keymap.set('n', '<leader>bD', '<cmd>Bdelete!<CR>')

-- oil
vim.keymap.set('n', '<leader>e', '<cmd>Oil --float<cr>', { noremap = true, desc = '[E]xplore directory of active buffer', silent = true })
vim.keymap.set('n', '<leader>E', '<cmd>Oil . --float<cr>', { noremap = true, desc = '[E]xplore root directory', silent = true })

-- harpoon
local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = 'Harpoon: add file' })
vim.keymap.set('n', '<leader>hf', ui.toggle_quick_menu, { desc = 'Harpoon: toggle quick menu' })

-- auto-session
vim.keymap.set('n', '<leader>ss', require('auto-session.session-lens').search_session, {
  noremap = true,
  desc = '[S]earch [S]essions',
})

-- trouble
vim.keymap.set('n', '<leader>xw', '<cmd>Trouble diagnostics toggle<cr>', {
  desc = 'Diagnostics (Trouble)',
  silent = true,
  noremap = true,
})
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', {
  desc = 'Buffer Diagnostics (Trouble)',
  silent = true,
  noremap = true,
})
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>', {
  desc = 'Location List (Trouble)',
  silent = true,
  noremap = true,
})
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', {
  desc = 'Quickfix List (Trouble)',
  silent = true,
  noremap = true,
})
vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp toggle focus=false<cr>', {
  desc = 'LSP Definitions / references / ... (Trouble)',
  silent = true,
  noremap = true,
})
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=true win.type=float<cr>', {
  desc = 'Symbols (Trouble)',
  silent = true,
  noremap = true,
})

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

-- undotree
vim.keymap.set('n', '<leader>uu', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })

-- zenmode
vim.keymap.set('n', '<leader>z', vim.cmd.ZenMode, { desc = 'Toggle [Z]en Mode' })

-- todo-comments
vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble toggle<cr>', { desc = 'Todo (Trouble)' })

-- mini
require('mini.trailspace').setup()
require('mini.pairs').setup()

-- telescope
local telescope_builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local telescope = require 'telescope'

telescope.setup {
  pickers = {
    find_files = {
      theme = 'dropdown',
      previewer = false,
      layout_config = { width = 0.4 },
    },
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
vim.keymap.set('n', '<leader><leader>', function()
  telescope_builtin.buffers { sort_mru = true, sort_lastused = true, ignore_current_buffer = true }
end, { desc = 'List open buffers' })

-- refactoring
local refactoring = require 'refactoring'
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
