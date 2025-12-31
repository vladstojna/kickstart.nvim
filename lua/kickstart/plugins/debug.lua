-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local function set_breakpoint(prompt, setter)
  vim.ui.input({ prompt = prompt }, function(input)
    if input == nil then
      vim.notify('No input provided', vim.log.levels.WARN)
    else
      input = string.gsub(input, '%s+', '')
      if input == '' then
        vim.notify('Setting standard breakpoint', vim.log.levels.INFO)
      end
      setter(input)
    end
  end)
end

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>bb',
      function()
        require('custom.dap.persistent_breakpoints').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>bB',
      function()
        set_breakpoint('Condition: ', require('custom.dap.persistent_breakpoints').set_breakpoint)
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<leader>bl',
      function()
        set_breakpoint('Log message: ', require('custom.dap.persistent_breakpoints').set_log_point)
      end,
      desc = 'Debug: Set log point',
    },
    {
      '<leader>bc',
      function()
        require('custom.dap.persistent_breakpoints').clear_breakpoints()
        require 'notify'('Breakpoints cleared', 'warn')
      end,
      desc = 'Debug: Clear Breakpoints',
    },
    {
      '<F4>',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Continue to cursor position',
    },
    {
      '<F6>',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate session.',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('custom.dap.ui.tab').toggle { reset = true }
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<F8>',
      function()
        require('custom.dap.run_last').run_last()
      end,
      desc = 'Debug: Run last session',
    },
    {
      '<leader>Dc',
      function()
        require('dapui').float_element('console', { enter = false })
      end,
      desc = 'Debug: Show console',
    },
    {
      '<leader>Db',
      function()
        require('dapui').float_element('breakpoints', { enter = true })
      end,
      desc = 'Debug: Show breakpoints',
    },
    {
      '<leader>Dw',
      function()
        require('dapui').float_element('watches', { enter = true })
      end,
      desc = 'Debug: Show watches',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    local telescope = require 'telescope'
    telescope.load_extension 'dap'

    vim.keymap.set('n', '<leader>sb', function()
      telescope.extensions.dap.list_breakpoints {
        preview = { hide_on_startup = false },
        show_line = false,
        path_display = function(_, path)
          local relpath = require('custom.util').string_remove_prefix(path, vim.fn.getcwd(0) .. '/')
          local tail = require('telescope.utils').path_tail(relpath)
          local highlights = {
            { { 0, #relpath - #tail }, 'Conceal' },
            { { #relpath - #tail, #relpath }, 'Boolean' },
          }

          return relpath, highlights
        end,
      }
    end, { desc = 'Debug: [S]earch [B]reakpoints' })

    vim.keymap.set('n', '<leader>sF', function()
      telescope.extensions.dap.frames { preview = { hide_on_startup = false } }
    end, { desc = 'Debug: [S]earch [F]rames' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup(vim.tbl_extend('error', { mappings = { expand = { 'z', '<Tab>' } } }, require 'custom.dap.ui.layout'))

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    --- Set all termination events to make sure they work with any debug adapter
    ---@param id string
    ---@param action function
    local function set_termination_events(id, action)
      dap.listeners.before.event_terminated[id] = action
      dap.listeners.before.event_exited[id] = action
      dap.listeners.before.disconnect[id] = action
    end

    dap.listeners.after.event_initialized['dapui_config'] = require('custom.dap.ui.tab').open
    dap.listeners.after.event_initialized['store_config'] = require('custom.dap.run_last').save_config
    dap.listeners.after.event_initialized['custom_dap_util'] = require('custom.dap.util').set_keymaps

    set_termination_events('dapui_config', require('custom.dap.ui.tab').close)

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    -- Install python specific config
    require('dap-python').setup()
    -- Setup additional adapter/configuration definitions
    require 'custom.dap'
  end,
}
