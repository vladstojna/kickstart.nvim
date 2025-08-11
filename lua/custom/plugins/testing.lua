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
    keys = {
      {
        '<leader>nr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Neotest: run nearest',
      },
      {
        '<leader>nl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Neotest: run last',
      },
      {
        '<leader>nd',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Neotest: debug nearest',
      },
      {
        '<leader>nD',
        function()
          require('neotest').run.run_last { strategy = 'dap' }
        end,
        desc = 'Neotest: debug last',
      },
      {
        '<leader>nf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Neotest: run file',
      },
      {
        '<leader>nF',
        function()
          require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' }
        end,
        desc = 'Neotest: debug file',
      },
      {
        '<leader>nx',
        function()
          require('neotest').run.stop { interactive = true }
        end,
        desc = 'Neotest: stop',
      },
      {
        '<leader>na',
        function()
          require('neotest').run.attach { interactive = true }
        end,
        desc = 'Neotest: attach',
      },
      {
        '<leader>ns',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Neotest: toggle summary',
      },
      {
        '<leader>no',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Neotest: toggle output panel',
      },
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
