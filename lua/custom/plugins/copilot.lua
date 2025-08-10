return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
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
  },
}
