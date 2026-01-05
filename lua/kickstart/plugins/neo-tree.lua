-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '\\',
      function()
        require('neo-tree.command').execute { position = 'current' }
      end,
      desc = 'Open NeoTree',
    },
  },
  opts = {
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function(_)
          vim.cmd [[ setlocal relativenumber ]]
        end,
      },
    },
    filesystem = {
      hijack_netrw_behavior = 'disabled',
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
