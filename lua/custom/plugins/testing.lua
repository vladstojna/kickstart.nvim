return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',

      -- adapters
      'alfaix/neotest-gtest',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        status = {
          virtual_text = true,
        },
        output = {
          open_on_run = true,
        },
        quickfix = {
          open = function()
            local has_trouble, trouble = pcall(require, 'trouble')
            if has_trouble then
              trouble.open { mode = 'quickfix', focus = false }
            else
              vim.cmd.copen()
            end
          end,
        },
        discovery = {
          enabled = false,
          concurrent = 1,
        },
        running = {
          concurrent = true,
        },
        summary = {
          animated = false,
        },
        adapters = {
          require('neotest-gtest').setup {
            debug_adapter = 'gdb',
          },
          require 'neotest-python',
        },
      }
    end,
  },
}
