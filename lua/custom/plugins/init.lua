-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  'RRethy/vim-illuminate',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-rsi',
  'JoosepAlviste/nvim-ts-context-commentstring',
  'rhysd/git-messenger.vim',
  'lambdalisue/suda.vim',
  'stevearc/dressing.nvim',
  {
    'mks-h/treesitter-autoinstall.nvim',
    config = function() require('treesitter-autoinstall').setup() end,
  },
  {
    'sindrets/diffview.nvim',
    opts = {
      hooks = {
        diff_buf_read = function(_) vim.opt_local.wrap = false end,
      },
    },
  },
  {
    'pearofducks/ansible-vim',
    ft = 'yaml.ansible',
  },
  {
    'famiu/bufdelete.nvim',
    keys = {
      {
        '<leader>bd',
        '<cmd>Bdelete<CR>',
        desc = 'Unload buffer',
      },
      {
        '<leader>bD',
        '<cmd>Bdelete!<CR>',
        desc = 'Unload buffer (force)',
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 2,
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { blink = { enabled = true } },
    },
  },
  {
    'rmagatti/auto-session',
    config = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals'
      require('auto-session').setup {
        log_level = 'error',
        git_use_branch_name = true,
        pre_save_cmds = {
          function()
            --- Close DAP UI tab before saving session so that the tab isn't
            --- persisted in the session file
            if package.loaded['dap'] and package.loaded['dapui'] then require('custom.dap.ui.tab').close() end
          end,
        },
      }
      vim.keymap.set('n', '<leader>S', require('auto-session.pickers').open_session_picker, {
        noremap = true,
        desc = 'List saved sessions',
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function() require('nvim-ts-autotag').setup() end,
  },
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function() vim.g.startuptime_tries = 10 end,
  },
  {
    'windwp/nvim-spectre',
    keys = {
      {
        '<leader>sR',
        function() require('spectre').open() end,
        desc = '[R]eplace in files (Spectre)',
      },
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
        width = require('custom.layout').goto_preview.width,
        height = require('custom.layout').goto_preview.height,
        default_mappings = true,
        debug = false,
        opacity = 10,
        post_open_hook = nil,
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
    config = function() require('lsp_signature').on_attach() end,
  },
  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    keys = {
      {
        '<leader>ng',
        function() require('neogen').generate { type = 'any' } end,
        desc = '[N]eogen [G]enerate',
      },
    },
    config = true,
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
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
      },
      float = {
        padding = 4,
        max_width = require('custom.layout').oil.float_max_width,
        preview_split = 'below',
        win_options = {
          winblend = 10,
        },
      },
      win_options = {
        winblend = 10,
        wrap = true,
      },
    },
    config = function(_, opts)
      require('oil').setup(opts)
      vim.keymap.set('n', '<leader>e', function() require('oil').open_float() end, {
        desc = 'Oil: [E]xplore directory of active buffer',
      })
      vim.keymap.set('n', '<leader>E', function() require('oil').open_float(vim.fn.getcwd()) end, {
        desc = 'Oil: [E]xplore CWD',
      })
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
    ft = 'tex',
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
    keys = {
      {
        '<leader>Rr',
        function() require('telescope').extensions.refactoring.refactors() end,
        mode = { 'n', 'x' },
        desc = 'Refactoring: show refactors',
      },
      {
        '<leader>Rp',
        function() require('refactoring').debug.print_var() end,
        mode = { 'n', 'x' },
        desc = 'Refactoring: print variable',
      },
      {
        '<leader>Rx',
        function() require('refactoring').debug.cleanup() end,
        desc = 'Refactoring: cleanup',
      },
    },
    config = function()
      require('refactoring').setup()
      require('telescope').load_extension 'refactoring'
    end,
  },
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    opts = {
      width = require('custom.layout').no_neck_pain.width,
      minSideBufferWidth = 1, -- always enable side buffers
      buffers = {
        wo = {
          fillchars = 'eob: ',
        },
      },
    },
    keys = {
      {
        '<leader>z',
        function() require('no-neck-pain').toggle() end,
        desc = 'Toggle centered view',
      },
    },
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
    ft = 'cpp', -- Assume presence of clangd
    opts = {
      memory_usage = {
        border = 'single',
      },
      symbol_info = {
        border = 'single',
      },
    },
    config = function(opts)
      require('clangd_extensions').setup(opts)
      vim.keymap.set('n', '<leader>ls', vim.cmd.ClangdShowSymbolInfo, { desc = 'Clangd: Show symbol info' })
      vim.keymap.set('n', '<leader>lh', vim.cmd.ClangdSwitchSourceHeader, { desc = 'Clangd: Switch between source and header' })
      vim.keymap.set('n', '<leader>lt', vim.cmd.ClangdTypeHierarchy, { desc = 'Clangd: Show type hierarchy' })
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
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      {
        '<leader>gs',
        '<cmd>Neogit<cr>',
        desc = 'Neogit: status',
      },
      {
        '<leader>gc',
        '<cmd>Neogit commit<cr>',
        desc = 'Neogit: commit popup',
      },
      {
        '<leader>gd',
        '<cmd>Neogit diff<cr>',
        desc = 'Neogit: diff',
      },
    },
    config = function()
      require('neogit').setup {
        graph_style = require('custom.util').neogit_graph_style(),
      }
    end,
  },
  { 'akinsho/git-conflict.nvim', version = '*', config = true, opts = { disable_diagnostics = true } },
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('neoclip').setup()
      vim.keymap.set('n', '<leader>sC', require('telescope').extensions.neoclip.default, {
        noremap = true,
        desc = '[S]earch [C]lipboard history',
      })
    end,
  },
  {
    'andythigpen/nvim-coverage',
    version = '*',
    cmd = {
      'Coverage',
      'CoverageLoad',
      'CoverageLoadLcov',
      'CoverageShow',
      'CoverageHide',
      'CoverageToggle',
      'CoverageClear',
      'CoverageSummary',
    },
    config = function()
      require('coverage').setup {
        auto_reload = true,
      }
    end,
  },
  {
    'yorickpeterse/nvim-pqf',
    config = function()
      require('pqf').setup {
        signs = vim.g.have_nerd_font and {
          error = { text = '󰅚 ', hl = 'DiagnosticSignError' },
          warning = { text = '󰀪 ', hl = 'DiagnosticSignWarn' },
          info = { text = '󰋽 ', hl = 'DiagnosticSignInfo' },
          hint = { text = '󰌶 ', hl = 'DiagnosticSignHint' },
        } or {
          error = { text = 'E', hl = 'DiagnosticSignError' },
          warning = { text = 'W', hl = 'DiagnosticSignWarn' },
          info = { text = 'I', hl = 'DiagnosticSignInfo' },
          hint = { text = 'H', hl = 'DiagnosticSignHint' },
        },
      }
    end,
  },
}
