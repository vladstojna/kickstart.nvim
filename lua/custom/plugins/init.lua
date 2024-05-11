-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-context',
  'theprimeagen/harpoon',
  'mbbill/undotree',
  'RRethy/vim-illuminate',
  'ahmedkhalf/project.nvim',
  'famiu/bufdelete.nvim',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-rsi',
  'JoosepAlviste/nvim-ts-context-commentstring',
  'sindrets/diffview.nvim',
  'rhysd/git-messenger.vim',
  'lambdalisue/suda.vim',
  'stevearc/dressing.nvim',
  'pearofducks/ansible-vim',
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    -- snippets
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      char = '┊',
    },
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'windwp/nvim-spectre',
    keys = {
      {
        '<leader>sR',
        function()
          require('spectre').open()
        end,
        desc = '[R]eplace in files (Spectre)',
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      use_diagnostic_signs = true,
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
      vim.notify.setup {
        background_colour = '#000000',
        stages = 'static',
      }
    end,
  },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 100, -- Width of the floating window
        height = 20, -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
      }
    end,
  },
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
    end,
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'BufRead',
    config = function()
      require('lsp_signature').on_attach()
    end,
  },
  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      local ng = require 'neogen'
      ng.setup {}

      vim.keymap.set('n', '<leader>ng', function()
        ng.generate { type = 'any' }
      end, { noremap = true, silent = true, desc = '[N]eogen [G]enerate' })
    end,
  },
  {
    'j-hui/fidget.nvim',
    opts = {
      progress = {
        suppress_on_insert = true,
      },
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    'folke/zen-mode.nvim',
    version = '*',
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.8,
        },
        plugins = {
          gitsigns = { enabled = false },
        },
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = ' ',
      },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'goolord/alpha-nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    },
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.buttons.val = {
        dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
        dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
        dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
      }
      require('alpha').setup(dashboard.opts)
    end,
  },
  {
    'laytan/cloak.nvim',
    version = '*',
    config = function()
      require('cloak').setup {
        enabled = true,
        cloak_character = '*',
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = 'Comment',
        -- Applies the length of the replacement characters for all matched
        -- patterns, defaults to the length of the matched pattern.
        cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
        patterns = {
          {
            -- Match any file starting with '.env'.
            -- This can be a table to match multiple file patterns.
            file_pattern = '.env*',
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
            cloak_pattern = '=.+',
          },
        },
      }
    end,
  },
  {
    'lervag/vimtex',
    config = function()
      local function get_editor(sys)
        local editor
        if sys == 'Darwin' then
          editor = 'skim'
        elseif sys == 'Linux' then
          editor = 'zathura'
        else -- windows?
          editor = 'zathura'
        end
        return editor
      end

      vim.g.vimtex_view_method = get_editor(vim.loop.os_uname().sysname)
    end,
  },
}
