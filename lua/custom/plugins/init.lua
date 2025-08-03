-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- width used for zen-mode and no-neck-pain
local centered_width = 120

return {
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-context',
  'theprimeagen/harpoon',
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
        merge_duplicates = true,
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
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {},
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
          width = centered_width,
          backdrop = 0.8,
        },
        plugins = {
          gitsigns = { enabled = false },
        },
        on_open = function(_)
          -- set cmdheight to 1 when entering zen-mode, as it hides the
          -- statusline, thus, no search count
          vim.o.cmdheight = 1
        end,
        on_close = function()
          vim.o.cmdheight = 0
        end,
      }
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
      float = {
        padding = 2,
        max_width = 100,
        max_height = 0,
        win_options = {
          winblend = 0,
        },
      },
      win_options = {
        winblend = 10,
        wrap = true,
      },
    },
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
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
    end,
  },
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    opts = {
      width = centered_width,
      minSideBufferWidth = 1, -- always enable side buffers
      autocmds = {
        skipEnteringNoNeckPainBuffer = true,
      },
      buffers = {
        wo = {
          fillchars = 'eob: ',
        },
      },
    },
    config = function(_, opts)
      require('no-neck-pain').setup(opts)
      vim.o.laststatus = 3
    end,
  },
  {
    'Badhi/nvim-treesitter-cpp-tools',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = 'cpp',
    config = function()
      require('nt-cpp-tools').setup {
        preview = {
          quit = 'q',
          accept = '<tab>',
        },
        header_extension = 'hpp',
        source_extension = 'cpp',
        custom_define_class_function_commands = {
          TSCppImplWrite = {
            output_handle = require('nt-cpp-tools.output_handlers').get_add_to_cpp(),
          },
        },
      }
      vim.keymap.set('n', '<leader>lgi', vim.cmd.TSCppDefineClassFunc, { desc = 'TSCpp: Implement out-of-class member functions' })
      vim.keymap.set('n', '<leader>lgc', vim.cmd.TSCppMakeConcreteClass, { desc = 'TSCpp: Create a concrete class' })
      vim.keymap.set('n', '<leader>lgd', vim.cmd.TSCppImplWrite, { desc = 'TSCpp: Add definition to cpp file' })
      vim.keymap.set('n', '<leader>lgt', vim.cmd.TSCppRuleOf3, { desc = 'TSCpp: Implement rule-of-3' })
      vim.keymap.set('n', '<leader>lgf', vim.cmd.TSCppRuleOf5, { desc = 'TSCpp: Implement rule-of-5' })
    end,
  },
  {
    'p00f/clangd_extensions.nvim',
    event = 'LspAttach',
    opts = {
      memory_usage = {
        border = 'single',
      },
      symbol_info = {
        border = 'single',
      },
    },
    config = function(opts)
      local clients = vim.lsp.get_clients { name = 'clangd' }
      if #clients >= 1 and clients[1].name == 'clangd' then
        require('clangd_extensions').setup(opts)
        vim.keymap.set('n', '<leader>ls', vim.cmd.ClangdShowSymbolInfo, { desc = 'Clangd: Show symbol info' })
        vim.keymap.set('n', '<leader>lh', vim.cmd.ClangdSwitchSourceHeader, { desc = 'Clangd: Switch between source and header' })
        vim.keymap.set('n', '<leader>lt', vim.cmd.ClangdTypeHierarchy, { desc = 'Clangd: Show type hierarchy' })
      end
    end,
  },
  {
    'jmacadie/telescope-hierarchy.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      {
        'ghi',
        '<cmd>Telescope hierarchy incoming_calls<cr>',
        desc = 'LSP: Call hierarchy (incoming)',
      },
      {
        'gho',
        '<cmd>Telescope hierarchy outgoing_calls<cr>',
        desc = 'LSP: Call hierarchy (outgoing)',
      },
    },
    opts = {
      extensions = {
        hierarchy = {
          initial_multi_expand = true,
          multi_depth = 5,
          layout_strategy = 'horizontal',
        },
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension 'hierarchy'
    end,
  },
  {
    'debugloop/telescope-undo.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      {
        '<leader>u',
        '<cmd>Telescope undo<cr>',
        desc = 'undo history',
      },
    },
    opts = {
      extensions = {
        undo = vim.tbl_extend('error', require('custom.telescope').fullscreen_spec(), {
          vim_diff_opts = { ctxlen = 4 },
          preview_title = 'Diff',
        }),
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension 'undo'
    end,
  },
}
