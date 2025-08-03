local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local act_layout = require 'telescope.actions.layout'

local fullscreen_setup_common = {
  prompt_position = 'top',
  width = function(_, cols, _)
    return math.min(math.floor(cols * 0.95), 200)
  end,
  height = function(_, _, rows)
    return math.floor(rows * 0.95)
  end,
  preview_cutoff = 10,
}

local standard_setup = {
  preview = { hide_on_startup = true },
  layout_strategy = 'vertical',
  layout_config = {
    vertical = {
      mirror = true,
      prompt_position = 'top',
      width = function(_, cols, _)
        return math.min(math.floor(cols * 0.9), 120)
      end,
      height = function(_, _, rows)
        return math.floor(rows * 0.8)
      end,
      preview_cutoff = 10,
      preview_height = 0.4,
    },
  },
}

local fullscreen_setup = {
  preview = { hide_on_startup = false },
  layout_strategy = 'flex',
  layout_config = {
    flex = { flip_columns = 100 },
    horizontal = vim.tbl_extend('error', fullscreen_setup_common, { mirror = false, preview_width = 0.5 }),
    vertical = vim.tbl_extend('error', fullscreen_setup_common, { mirror = true, preview_height = 0.5 }),
  },
}

local M = {
  fullscreen_spec = function()
    return fullscreen_setup
  end,

  setup = function()
    require('telescope').setup {
      defaults = vim.tbl_extend('error', standard_setup, {
        winblend = 10,
        wrap_results = true,
        sorting_strategy = 'ascending',
        path_display = { 'filename_first' },
        mappings = {
          n = {
            ['o'] = act_layout.toggle_preview,
          },
          i = {
            ['<C-o>'] = act_layout.toggle_preview,
          },
        },
      }),
      pickers = {
        live_grep = fullscreen_setup,
        grep_string = fullscreen_setup,
        diagnostics = fullscreen_setup,
        find_files = {
          hidden = true,
          no_ignore = false,
          file_ignore_patterns = {
            '.git/.*',
          },
        },
        buffers = {
          sort_lastused = true,
          sort_mru = true,
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
  end,

  keymaps = function()
    vim.keymap.set('n', '<leader>sa', function()
      builtin.find_files {
        hidden = true,
        no_ignore = true,
      }
    end, { desc = '[S]earch [A]ll Files (hidden & ignored)' })

    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'List open buffers' })
  end,
}

return M
