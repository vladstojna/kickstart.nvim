return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    keys = {
      {
        '<leader>tC',
        function()
          local cp_client = require 'copilot.client'
          local cp_cmd = require 'copilot.command'
          local notify_message = nil
          if cp_client.is_disabled() then
            cp_cmd.enable()
            notify_message = 'Copilot enabled'
          else
            cp_cmd.disable()
            notify_message = 'Copilot disabled'
          end
          vim.notify(notify_message, vim.log.levels.INFO)
        end,
        silent = true,
        noremap = true,
        desc = '[T]oggle [C]opilot Suggestions',
      },
    },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = 'off',
          },
        },
      },
    },
    config = function(_, opts)
      require('copilot').setup(opts)
      -- Comes enabled by default so, instead, we disable it by when the plugin
      -- is loaded
      require('copilot.command').disable()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      window = {
        layout = 'vertical',
        width = 0.33,
      },
      auto_insert_mode = true,
      show_folds = false,

      -- Use visual selection, fallback to current line
      selection = function(source)
        local select = require 'CopilotChat.select'
        return select.visual(source) or select.line(source)
      end,

      headers = {
        user = '👤  ',
        assistant = '🤖  ',
        tool = '🔧  ',
      },
    },
    keys = {
      {
        '<leader>tc',
        function()
          require('CopilotChat').toggle()
        end,
        silent = true,
        noremap = true,
        desc = '[T]oggle [C]opilot Chat',
      },
    },
  },
}
