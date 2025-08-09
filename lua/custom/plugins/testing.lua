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
